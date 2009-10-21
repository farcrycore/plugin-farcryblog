<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Comment type --->
<!--- @@Description: Blog comment type component for the FarCry Blog plugin --->
<cfcomponent displayname="Blog Comment" extends="farcry.core.packages.types.types" output="false" bObjectBroker="true" lObjectBrokerWebskins="displayTeaserStandard:15,displayFormComment:0"
	hint="Manage and review comments across your entire blog.">

<!--- properties --->
<cfproperty ftSeq="2" ftFieldset="Blog Comment" name="description" type="longchar" required="false" default="" hint="Comment description." ftLabel="Description" ftValidation="required" />
<cfproperty ftSeq="3" ftFieldset="Blog Comment" name="commentHandle" type="string" required="false" default="" hint="Name or handle of poster."  ftLabel="Name" />
<cfproperty ftSeq="4" ftFieldset="Blog Comment" name="email" type="string" required="false" default="" hint="Email address of poster." ftLabel="Email" ftValidation="validate-email" />
<cfproperty ftSeq="5" ftFieldset="Blog Comment" name="bPublish" type="boolean" required="true" default="1" hint="Flag for auto publishing comment" ftLabel="Published" />
<cfproperty ftSeq="6" ftFieldset="Blog Comment" name="website" type="string" required="false" default="" hint="Website address of poster." ftLabel="Website" ftType="url" />
<cfproperty ftSeq="7" ftFieldset="Blog Comment" name="parentID" type="UUID" required="false" default="" hint="Parent content object reference." ftLabel="Parent Blog Post" ftJoin="farBlogPost" />

<cfproperty ftSeq="20" ftFieldset="Blog Comment" name="bSubscribe" type="boolean" required="true" default="0" hint="Flag for thread subscription." ftLabel="Subscribe to thread?" ftType="boolean" />

<cfproperty ftSeq="30" ftFieldset="Blog Comment" name="profileID" type="UUID" required="false" default="" hint="A member profile if commentor is a member" ftLabel="MemberID" ftJoin="dmProfile" />

<!--- IMPORT TAG LIBRARIES --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!--- methods --->
<cffunction name="getParentPost" access="public" output="false" returntype="query" hint="Returns the parent blog post for a comment.">
	<cfargument name="objectID" required="true" type="UUID" hint="Object reference for the content item." />

	<cfset var qPost = querynew("objectID, title") />

	<cfquery datasource="#application.dsn#" name="qPost">
		SELECT p.objectID, p.title
		FROM farBlogPost p
		INNER JOIN farBlogComment c
			ON p.objectID = c.parentID
			AND c.objectID = <cfqueryparam value="#arguments.objectID#" cfsqltype="cf_sql_idstamp" />
	</cfquery>

	<cfreturn qPost />
</cffunction>

<cffunction name="getComments" access="public" output="false" returntype="query" hint="Returns all comments that match a specific content reference.">
	<cfargument name="parentID" required="true" type="UUID" hint="Object reference for the parent content item." />

	<cfset var qComments = querynew("objectID, description, commentHandle, dateTimeCreated") />

	<cfquery datasource="#application.dsn#" name="qComments">
		SELECT objectID, description, commentHandle, dateTimeCreated
		FROM farBlogComment
		WHERE 
			parentID = <cfqueryparam value="#arguments.parentID#" cfsqltype="cf_sql_idstamp">
		ORDER BY dateTimeCreated
	</cfquery>

	<cfreturn qComments />
</cffunction>

<cffunction name="getRecentComments" access="public" output="false" returntype="query" hint="Return a query of recent x blog comments.">
	<cfargument name="maxrows" default="5" type="numeric" />

	<cfset var q = querynew("objectID, commentHandle, dateTimeCreated") />

	<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
		SELECT objectID, commentHandle, dateTimeCreated
		FROM farBlogComment
		WHERE
			bPublish=1
		ORDER BY dateTimeCreated DESC
	</cfquery>

	<cfreturn q />
</cffunction>


<!--- save events --->
<cffunction name="afterSave" access="public" output="false" returntype="struct" hint="Called from setData and createData and run after the object has been saved.">
	<cfargument name="stProperties" required="true" type="struct" hint="A structure containing the contents of the properties that were saved to the object." />

	<cfset arguments.stProperties = super.afterSave(stProperties=arguments.stProperties) />

	<cfif structKeyExists(arguments.stProperties, "parentID")>
		<!--- Flush the blog post this comment is refering to. --->
		<cfset createobject("component", "farcry.core.packages.fourq.objectBroker").removeFromObjectBroker(lObjectIDs=arguments.stProperties.parentID, typename="farBlogPost") />
	
		<!--- send email alerts --->
		<cfset sendAuthorAlert(objectID=arguments.stProperties.objectID) />
		<cfset sendSubscriptionAlert(objectID=arguments.stProperties.objectID) />
	</cfif>
	<cfreturn stProperties />
</cffunction>

<cffunction name="beforeSave" access="public" output="false" returntype="struct">
	<cfargument name="stProperties" required="true" type="struct" />
	<cfargument name="stFields" required="true" type="struct" />
	<cfargument name="stFormPost" required="false" type="struct" />

	<cfset var i = "" />
	
	<cfloop list="description,email,website,commentHandle" index="i">
		<cfif structKeyExists(arguments.stProperties, i)>
			<cfset arguments.stProperties[i] = safetext(arguments.stProperties[i]) />
		</cfif>
	</cfloop>
	
	<cfif structKeyExists(arguments.stProperties, "description")>
		<cfset arguments.stProperties.description = activateURL(htmleditformat(arguments.stProperties.description)) />
		<cfset arguments.stProperties.label = left(arguments.stProperties.description,50) />
	</cfif>
	
	<cfset arguments.stProperties = super.beforeSave(stProperties=arguments.stProperties, stFields=arguments.stFields, stFormPost=arguments.stFormPost) />

	<cfreturn arguments.stProperties />
</cffunction>

<cffunction name="unsubscribeUser" access="public" output="false" returntype="void">
	<cfargument name="objectID" required="true" type="UUID" hint="UUID for the blog post of comment." />

	<cfset var stComment = getData(objectID=arguments.objectID) />
	<cfset var qSubscribers = "" />
	<cfset var stProperties = structNew() />
	<cfset var stResult = structNew() />

	<!--- Get all the comments made on this post by this user. --->
	<cfquery datasource="#application.dsn#" name="qSubscribers">
	SELECT objectid
	FROM farBlogComment
	WHERE parentID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stComment.parentID#" />
	AND email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stComment.email#" />
	</cfquery>
	
	<cfif qSubscribers.recordCount>
		<cfloop query="qSubscribers">
			<cfset stProperties = structNew() />
			<cfset stProperties.objectid = qSubscribers.objectid />
			<cfset stProperties.bSubscribe = 0 />
			
			<cfset stResult = setData(stProperties="#stProperties#") />
		</cfloop>
	</cfif>
</cffunction>


<!--- send alerts --->
<cffunction name="sendAuthorAlert" access="private" output="false" returntype="void">
	<cfargument name="objectID" required="true" type="UUID" />

	<cfset var stObj = getData(objectID=arguments.objectID) />
	<cfset var stPost = application.fapi.getContentObject(objectID=stObj.parentID,typename="farBlogPost") />
	<cfset var stBlog = application.fapi.getContentObject(objectid=stPost.farBlogID,typename="farBlog") />
	<cfset var stProfile = application.fapi.getContentObject(objectid=stPost.dmProfileID,typename="dmProfile") />
	
	<cfif not len(stProfile.emailaddress)>
		<cfreturn />
	</cfif>
	
	<cfmail to="#stProfile.emailaddress#" from="#application.config.general.adminemail#" subject="#stBlog.title#: #left(stPost.title, "50")#" type="text">
<cfoutput>
There's been an update to the post you made at *#stBlog.title#*

#stPost.title#
-------------------------------------------------
#stPost.teaser#

New Comment
-------------------------------------------------
#stObj.description#
#stObj.commentHandle#


Link back to the thread:
#application.fapi.getLink(objectid=stObj.parentID,includedomain=true)#
</cfoutput>
	</cfmail>

</cffunction>

<cffunction name="sendSubscriptionAlert" access="private" output="false" returntype="void">
	<cfargument name="objectID" required="true" type="UUID" />

	<cfset var stObj = getData(objectID=arguments.objectID) />
	<cfset var oPost=createobject("component", application.stCOAPI["farBlogPost"].typepath) />
	<cfset var stPost = application.fapi.getContentObject(objectID=stObj.parentID,typename="farBlogPost") />
	<cfset var stProfile = application.fapi.getContentObject(objectID=stPost.dmProfileID,typename="dmProfile") />
	<cfset var stBlog = application.fapi.getContentObject(objectid=stPost.farBlogID,typename="farBlog") />
	<cfset var qSubscribers=querynew("objectID") />
	<cfset var lSubscribersSent = "" />
	<cfset var senderEmail = "" />
	
	<cfif len(stProfile.emailaddress)>
		<cfset senderEmail = stProfile.emailaddress />
	<cfelse>
		<cfset senderEmail = application.config.general.adminemail />
	</cfif>

	<cfquery datasource="#application.dsn#" name="qSubscribers">
		SELECT 		objectID, email
		FROM 		farBlogComment
		WHERE 		parentID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stObj.parentID#" />
					AND email <> ''
					AND bSubscribe = 1
		ORDER BY 	dateTimeCreated DESC
	</cfquery>

	<cfloop query="qSubscribers">
		<cfif not listfindnocase(lSubscribersSent, email)>
			<cftry>
				<cfmail to="#qSubscribers.email#" from="#senderEmail#" subject="#stBlog.title#: #left(stPost.title, "50")#" type="text">
	<cfoutput>There's been an update to the thread you subscribed to at *#stBlog.title#*
	
	#stPost.title#
	-------------------------------------------------
	#stPost.teaser#
	
	New Comment
	-------------------------------------------------
	#stObj.description#
	#stObj.commentHandle#
	
	
	Link back to the thread:
	#application.fapi.getLink(objectid=stBlog.objectid,includedomain=true)#
	
	If you would like to unsubscribe from this thread follow the link below:
	#application.fapi.getLink(objectid=qSubscribers.objectid,includedomain=true,bodyView="displayUnsubscribeUser")#
	</cfoutput>
				</cfmail>
				<cfcatch type="any"><cftrace type="warning" text="Error sending Subscription alert to [#qSubscribers.email#]."></cfcatch>
			</cftry>
			<cfset lSubscribersSent = listappend(lSubscribersSent, email) />
		</cfif>
	</cfloop>

</cffunction>


<cffunction name="safetext" access="public" output="false" returntype="string" hint="Removes potentially nasty HTML text.">
	<cfargument name="text" required="true" type="string" hint="String to be modified">

	<cfscript>
	/**
	 * Removes potentially nasty HTML text.
	 * Version 2 by Lena Aleksandrova - changes include fixing a bug w/ arguments and use of REreplace where REreplaceNoCase should have been used.
	 *
	 * @param text 	 String to be modified. (Required)
	 * @param strip 	 Boolean value (defaults to false) that determines if HTML should be stripped or just escaped out. (Optional)
	 * @param badTags 	 A list of bad tags. Has a long default list. Consult source. (Optional)
	 * @param badEvents 	 A list of bad HTML events. Has a long default list. Consult source. (Optional)
	 * @return Returns a string.
	 * @author Nathan Dintenfass (nathan@changemedia.com)
	 * @version 3, March 19, 2003
	 */
	//<!--- function safetext(text) { --->
		//default mode is "escape"
		var mode = "escape";
		//the things to strip out (badTags are HTML tags to strip and badEvents are intra-tag stuff to kill)
		//you can change this list to suit your needs
		var badTags = "SCRIPT,OBJECT,APPLET,EMBED,FORM,LAYER,ILAYER,FRAME,IFRAME,FRAMESET,PARAM,META";
		var badEvents = "onClick,onDblClick,onKeyDown,onKeyPress,onKeyUp,onMouseDown,onMouseOut,onMouseUp,onMouseOver,onBlur,onChange,onFocus,onSelect,javascript:";
		var stripperRE = "";
	
		//set up variable to parse and while we're at it trim white space
		var theText = trim(text);
		//find the first open bracket to start parsing
		var obracket = find("<",theText);
		//var for badTag
		var badTag = "";
		//var for the next start in the parse loop
		var nextStart = "";
		//if there is more than one argument and the second argument is boolean TRUE, we are stripping
		if(arraylen(arguments) GT 1 AND isBoolean(arguments[2]) AND arguments[2]) mode = "strip";
		if(arraylen(arguments) GT 2 and len(arguments[3])) badTags = arguments[3];
		if(arraylen(arguments) GT 3 and len(arguments[4])) badEvents = arguments[4];
		//the regular expression used to stip tags
		stripperRE = "</?(" & listChangeDelims(badTags,"|") & ")[^>]*>";
		//Deal with "smart quotes" and other "special" chars from MS Word
		theText = replaceList(theText,chr(8216) & "," & chr(8217) & "," & chr(8220) & "," & chr(8221) & "," & chr(8212) & "," & chr(8213) & "," & chr(8230),"',',"","",--,--,...");
		//if escaping, run through the code bracket by bracket and escape the bad tags.
		if(mode is "escape"){
			//go until no more open brackets to find
			while(obracket){
				//find the next instance of one of the bad tags
				badTag = REFindNoCase(stripperRE,theText,obracket,1);
				//if a bad tag is found, escape it
				if(badTag.pos[1]){
					theText = replace(theText,mid(TheText,badtag.pos[1],badtag.len[1]),HTMLEditFormat(mid(TheText,badtag.pos[1],badtag.len[1])),"ALL");
					nextStart = badTag.pos[1] + badTag.len[1];
				}
				//if no bad tag is found, move on
				else{
					nextStart = obracket + 1;
				}
				//find the next open bracket
				obracket = find("<",theText,nextStart);
			}
		}
		//if not escaping, assume stripping
		else{
			theText = REReplaceNoCase(theText,stripperRE,"","ALL");
		}
		//now kill the bad "events" (intra tag text)
		theText = REReplaceNoCase(theText,(ListChangeDelims(badEvents,"|")),"","ALL");
		//return theText
		return theText;
	//<!--- } --->
	</cfscript>
</cffunction>


<cffunction name="activateURL" access="public" output="false" returntype="string" hint="This function takes URLs in a text string and turns them into links.">
	<cfargument name="string" required="true" type="string" hint="Text to parse.">

	<cfscript>
	/**
	 * This function takes URLs in a text string and turns them into links.
	 * Version 2 by Lucas Sherwood, lucas@thebitbucket.net.
	 * Version 3 Updated to allow for ;
	 *
	 * @param string 	 Text to parse. (Required)
	 * @param target 	 Optional target for links. Defaults to "". (Optional)
	 * @param paragraph 	 Optionally add paragraphFormat to returned string. (Optional)
	 * @return Returns a string.
	 * @author Joel Mueller (lucas@thebitbucket.netjmueller@swiftk.com)
	 * @version 3, August 11, 2004
	 */
	//<!--- function activateURL(string) { --->
		var nextMatch = 1;
		var objMatch = "";
		var outstring = "";
		var thisURL = "";
		var thisLink = "";
		var	target = IIf(arrayLen(arguments) gte 2, "arguments[2]", DE(""));
		var paragraph = IIf(arrayLen(arguments) gte 3, "arguments[3]", DE("false"));
	
		do {
			objMatch = REFindNoCase("(((https?:|ftp:|gopher:)\/\/)|(www\.|ftp\.))[-[:alnum:]\?%,\.\/&##!;@:=\+~_]+[A-Za-z0-9\/]", string, nextMatch, true);
			if (objMatch.pos[1] GT nextMatch OR objMatch.pos[1] EQ nextMatch) {
				outString = outString & Mid(String, nextMatch, objMatch.pos[1] - nextMatch);
			} else {
				outString = outString & Mid(String, nextMatch, Len(string));
			}
			nextMatch = objMatch.pos[1] + objMatch.len[1];
			if (ArrayLen(objMatch.pos) GT 1) {
				// If the preceding character is an @, assume this is an e-mail address
				// (for addresses like admin@ftp.cdrom.com)
				if (Compare(Mid(String, Max(objMatch.pos[1] - 1, 1), 1), "@") NEQ 0) {
					thisURL = Mid(String, objMatch.pos[1], objMatch.len[1]);
					thisLink = "<A HREF=""";
					switch (LCase(Mid(String, objMatch.pos[2], objMatch.len[2]))) {
						case "www.": {
							thisLink = thisLink & "http://";
							break;
						}
						case "ftp.": {
							thisLink = thisLink & "ftp://";
							break;
						}
					}
					thisLink = thisLink & thisURL & """";
					if (Len(Target) GT 0) {
						thisLink = thisLink & " TARGET=""" & Target & """";
					}
					thisLink = thisLink & ">" & thisURL & "</A>";
					outString = outString & thisLink;
					// String = Replace(String, thisURL, thisLink);
					// nextMatch = nextMatch + Len(thisURL);
				} else {
					outString = outString & Mid(String, objMatch.pos[1], objMatch.len[1]);
				}
			}
		} while (nextMatch GT 0);
	
		// Now turn e-mail addresses into mailto: links.
		outString = REReplace(outString, "([[:alnum:]_\.\-]+@([[:alnum:]_\.\-]+\.)+[[:alpha:]]{2,4})", "<A HREF=""mailto:\1"">\1</A>", "ALL");
	
		if (paragraph) {
			outString = ParagraphFormat(outString);
		}
		return outString;
	//<!--- } --->
	</cfscript>
</cffunction>


</cfcomponent>