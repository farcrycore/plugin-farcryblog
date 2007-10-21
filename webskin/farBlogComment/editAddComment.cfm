<cfsetting enablecfoutputonly="true" />
<cfimport prefix="ft" taglib="/farcry/core/tags/formtools" />

		

<!------------------------------- 
ACTION:
-------------------------------->
<!--- PERFORM SERVER SIDE VALIDATION --->
<ft:serverSideValidation lrequiredfields="bCaptcha" />

<ft:processform action="Post Comment" url="/index.cfm?#cgi.query_string#&commentAdded=true##thanks">

	<!--- process action items --->
	<ft:processformobjects typename="farBlogComment" r_stproperties="stprops">
		<!--- convert description edit format --->
		<cfset description = ActivateURL(htmleditformat(stprops.description)) />

		<cfscript>
		stprops.label=safetext(stprops.subject, "true");
		stprops.subject=stprops.label;
		stprops.description=description;
		stprops.email=safetext(stprops.email, "true");
		stprops.website=safetext(stprops.website, "true");
		stprops.commenthandle=safetext(stprops.commenthandle, "true");
		</cfscript>
		
		<cfif stobj.parentid eq "">
			<ft:break />
		</cfif>
		
	</ft:processformobjects>

</ft:processform>


<!------------------------------- 
VIEW:
-------------------------------->
<cfif NOT structkeyexists(URL, "commentAdded")>
	
	<!--- comments form --->
	<cfoutput><a name="comment"></a></cfoutput>
	
	<ft:form action="##comment">
		<ft:object stobject="#stobj#" lexcludefields="label,parentid" format="edit" legend="Comment Details" />
		<ft:farcrybutton value="Post Comment" /> 
	</ft:form>

<cfelse>

	
	<cfoutput>
	<a name="thanks" />
	<h2>Thanks for your comment!</h2>
	</cfoutput>
	
</cfif>

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
function safetext(text) {
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
}
</cfscript>

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
function ActivateURL(string) {
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
}
</cfscript>

<cfsetting enablecfoutputonly="false" />