<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display comment teaser --->
<!--- @@Description: Display of a teaser for a blog comment content item in the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->


<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayCommentHandle" r_html="htmlCommentHandle" />

<cfoutput>
<div class="bubble">
	<blockquote>
		<p><strong>#stObj.subject#</strong><br />#stObj.description#</p>
	</blockquote>
	<cite><span><strong>#htmlCommentHandle#</strong> on #dateformat(stObj.dateTimeCreated)# #timeformat(stObj.dateTimeCreated)#</span></cite>
	<hr />
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />