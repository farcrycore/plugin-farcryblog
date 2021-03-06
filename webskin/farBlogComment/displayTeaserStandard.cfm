<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Display comment teaser --->
<!--- @@Description: Display of a teaser for a blog comment content item in the FarCry Blog plugin --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!--- merge url and handle, as needed --->
<skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayCommentHandle" r_html="htmlCommentHandle" />

<cfoutput>
<div class="bubble" id="comment-#stobj.objectid#">
	<p>
	#stObj.description#
	<br /><cite><span><strong>#htmlCommentHandle#</strong> on #dateformat(stObj.dateTimeCreated)# #timeformat(stObj.dateTimeCreated)#</span></cite>
	</p>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />