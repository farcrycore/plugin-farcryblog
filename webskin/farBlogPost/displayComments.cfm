<cfsetting enablecfoutputonly="true" />
<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au $

|| DESCRIPTION || 
$Description: List blog comments for a specific blog post. $

|| DEVELOPER ||
$Developer: Geoff Bowers (modius@daemon.com.au)$
--->
<!--- @@displayname: Blog Comment List  --->

<!--- import tag libraries --->
<cfimport prefix="skin" taglib="/farcry/core/tags/webskin">
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- data providers --->
<cfset comment=createobject("component", application.stcoapi["farblogcomment"].packagepath) />
<cfset qComments=comment.getcomments(parentid=stobj.objectid) />

<cfif qComments.recordcount>

	<cfoutput>
	<h3>Reader Comments</h3>
	<p>&nbsp;</p>
	</cfoutput>

	<cfloop query="qComments">
		<cfset commentHTML=comment.getview(objectid=qcomments.objectid, template="displayCommentBubble") />
		<cfoutput>#commentHTML#</cfoutput>
	</cfloop>

</cfif>


<cfsetting enablecfoutputonly="false" />
