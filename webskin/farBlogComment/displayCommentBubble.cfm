<cfsetting enablecfoutputonly="true" />

<cfif NOT len(stobj.commenthandle)>
	<cfset stobj.commenthandle = "Secret Admirer" />
</cfif>
<cfif len(stobj.website)>
	<cfset stobj.commenthandle = '<a href="#stobj.website#">#stobj.commenthandle#</a>' />
</cfif>

<cfoutput>
<div class="bubble">
	<blockquote>
		<p><strong>#stobj.subject#</strong><br /> #stobj.description#</p>
	</blockquote>
	<cite><span><strong>#stobj.commenthandle#</strong> on #dateformat(stobj.datetimecreated)# #timeformat(stobj.datetimecreated)#</span></cite>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />