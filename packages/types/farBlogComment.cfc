<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Blog: Comment type --->
<!--- @@Description: Blog comment type component for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<cfcomponent displayname="Blog Comment" extends="farcry.core.packages.types.types" output="false" bObjectBroker="true" lObjectBrokerWebskins="displayTeaserStandard:15,displayCommentForm:0"
	hint="Blog comments">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="Blog Comment" name="subject" type="string" required="false" default="" hint="Subject of comment." ftLabel="Subject" bLabel="true" />
<cfproperty ftSeq="2" ftFieldset="Blog Comment" name="description" type="longchar" required="false" default="" hint="Comment description." ftLabel="Description" />
<cfproperty ftSeq="3" ftFieldset="Blog Comment" name="commentHandle" type="string" required="false" default="" hint="Name or handle of poster."  ftLabel="Name" />
<cfproperty ftSeq="4" ftFieldset="Blog Comment" name="email" type="string" required="false" default="" hint="Email address of poster." ftLabel="Email" ftValidation="validate-email" />
<cfproperty ftSeq="5" ftFieldset="Blog Comment" name="website" type="string" required="false" default="" hint="Website address of poster." ftLabel="Website" ftType="url" />
<cfproperty ftSeq="6" ftFieldset="Blog Comment" name="parentID" type="UUID" required="false" default="" hint="Parent content object reference." ftLabel="Parent Blog Post" ftJoin="farBlogPost" />

<cfproperty ftSeq="20" ftFieldset="Blog Comment" name="bSubscribe" type="boolean" required="true" default="0" hint="Flag for thread subscription." ftLabel="Subscribe to thread?" ftType="boolean" />

<!--- methods --->
<cffunction name="getParentPost" access="public" output="false" returntype="query" hint="Returns the parent blog post for a comment.">
	<cfargument name="objectID" required="true" type="UUID" hint="Object reference for the content item." />

	<cfset var qPost = querynew("objectID, title") />

	<cfquery datasource="#application.dsn#" name="qPost">
	SELECT p.objectID, p.title
	FROM farBlogPost p
	INNER JOIN farBlogComment c
		ON p.objectID = c.parentID
		AND c.objectID = <cfqueryparam value="#arguments.objectID#" cfsqltype="cf_sql_idstamp">
	</cfquery>

	<cfreturn qPost />
</cffunction>

<cffunction name="getComments" access="public" output="false" returntype="query" hint="Returns all comments that match a specific content reference.">
	<cfargument name="parentID" required="true" type="UUID" hint="Object reference for the parent content item." />

	<cfset var qComments = querynew("objectID, subject, description, commentHandle, dateTimeCreated") />

	<cfquery datasource="#application.dsn#" name="qComments">
	SELECT objectID, subject, description, commentHandle, dateTimeCreated
	FROM farBlogComment
	WHERE parentID = <cfqueryparam value="#arguments.parentID#" cfsqltype="cf_sql_idstamp">
	ORDER BY dateTimeCreated
	</cfquery>

	<cfreturn qComments />
</cffunction>

<cffunction name="getRecentComments" access="public" output="false" returntype="query" hint="Return a query of recent x blog comments.">
	<cfargument name="maxrows" default="5" type="numeric" />

	<cfset var q = querynew("objectID, subject, commentHandle, dateTimeCreated") />

	<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
	SELECT objectID, subject, commentHandle, dateTimeCreated
	FROM farBlogComment
	ORDER BY dateTimeCreated DESC
	</cfquery>

	<cfreturn q />
</cffunction>


<!--- save events --->
<cffunction name="afterSave" access="public" output="false" returntype="struct" hint="Called from setData and createData and run after the object has been saved.">
	<cfargument name="stProperties" required="true" type="struct" hint="A structure containing the contents of the properties that were saved to the object." />

	<cfset arguments.stProperties = super.afterSave(stProperties=arguments.stProperties) />

	<!--- Flush the blog post this comment is refering to. --->
	<cfset createobject("component", "farcry.core.packages.fourq.objectBroker").removeFromObjectBroker(lObjectIDs=arguments.stProperties.parentID, typename="farBlogPost") />

	<!--- send email alerts --->
	<cfset sendAuthorAlert(objectID=arguments.stProperties.objectID) />
	<cfset sendSubscriptionAlert(objectID=arguments.stProperties.objectID) />

	<cfreturn stProperties />
</cffunction>

<cffunction name="beforeSave" access="public" output="false" returntype="struct">
	<cfargument name="stProperties" required="true" type="struct" />
	<cfargument name="stFields" required="true" type="struct" />
	<cfargument name="stFormPost" required="false" type="struct" />

	<cfset arguments.stProperties = super.beforeSave(stProperties=arguments.stProperties, stFields=arguments.stFields, stFormPost=arguments.stFormPost) />

	<cfreturn arguments.stProperties />
</cffunction>

<cffunction name="unsubscribeUser" access="public" output="false" returntype="void">
	<cfargument name="objectID" required="true" type="UUID" hint="UUID for the blog post of comment." />

	<cfset var stObj = getData(objectID=arguments.objectID) />
	<cfset var qSubscribers = "" />

	<cfquery datasource="#application.dsn#" name="qSubscribers">
	UPDATE farBlogComment
	SET bSubscribe = 0
	WHERE parentID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stObj.parentID#" />
		AND email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stObj.email#" />
	</cfquery>
</cffunction>


<!--- send alerts --->
<cffunction name="sendAuthorAlert" access="private" output="false" returntype="void">
	<cfargument name="objectID" required="true" type="UUID" />

	<cfset var stObj = getData(objectID=arguments.objectID) />
	<cfset var oPost = createobject("component", application.stCOAPI["farBlogPost"].typepath) />
	<cfset var stPost = oPost.getData(objectID=stObj.parentID) />
	<cfset var postURL = application.factory.oFU.getFU(stObj.parentID) />

	<cfmail to="#application.config.farcryblog.authorEmail#" from="#application.config.farcryblog.authorEmail#" subject="#application.config.farcryblog.blogTitle#: #left(stPost.title, "50")#" type="text">
<cfoutput>
There's been an update to the post you made at *#application.config.farcryblog.blogTitle#*

#stPost.title#
-------------------------------------------------
#stPost.teaser#

New Comment
-------------------------------------------------
#stObj.subject#
#stObj.description#
#stObj.commentHandle#


Link back to the thread:
http://#cgi.SERVER_NAME##postURL#
</cfoutput>
	</cfmail>

</cffunction>

<cffunction name="sendSubscriptionAlert" access="private" output="false" returntype="void">
	<cfargument name="objectID" required="true" type="UUID" />

	<cfset var stObj=getData(objectID=arguments.objectID) />
	<cfset var oPost=createobject("component", application.stCOAPI["farBlogPost"].typepath) />
	<cfset var stPost=oPost.getData(objectID=stObj.parentID) />
	<cfset var postURL = application.factory.oFU.getFU(stObj.parentID) />
	<cfset var qSubscribers=querynew("objectID") />
	<cfset var lSubscribersSent = "" />

	<cfquery datasource="#application.dsn#" name="qSubscribers">
	SELECT objectID, email
	FROM farBlogComment
	WHERE parentID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stObj.parentID#" />
		AND email <> ''
		AND bSubscribe = 1
	ORDER BY dateTimeCreated DESC
	</cfquery>

	<cfloop query="qSubscribers">
		<cfif not listfindnocase(lSubscribersSent, email)>
			<cfmail to="#qSubscribers.email#" from="#application.config.farcryblog.authorEmail#" subject="#application.config.farcryblog.blogTitle#: #left(stPost.title, "50")#" type="text">
<cfoutput>There's been an update to the thread you subscribed to at *#application.config.farcryblog.blogTitle#*

#stPost.title#
-------------------------------------------------
#stPost.teaser#

New Comment
-------------------------------------------------
#stObj.subject#
#stObj.description#
#stObj.commentHandle#


Link back to the thread:
http://#cgi.SERVER_NAME##postURL#

If you would like to unsubscribe from this thread follow the link below:
http://#cgi.SERVER_NAME#/index.cfm?objectID=#qSubscribers.objectID#&type=farBlogComment&view=displayPageUnsubscribe
</cfoutput>
			</cfmail>
			<cfset lSubscribersSent = listappend(lSubscribersSent, email) />
		</cfif>
	</cfloop>

</cffunction>

</cfcomponent>