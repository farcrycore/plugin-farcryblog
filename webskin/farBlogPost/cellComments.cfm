<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Comments admin cell --->

<cfset stStats = getCommentStats(stObj.objectid) />

<cfif stObj.status eq "approved" and stObj.bComment>
	<cfoutput>
		<a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogComment.cfm&plugin=farcryblog&farBlogPostID=#stObj.objectid#&status=all">#stStats.total# Comments</a><br />
		<cfif not stObj.bAutoPublish><a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogComment.cfm&plugin=farcryblog&farBlogPostID=#stObj.objectid#&status=pending">#stStats.pending# awaiting approval</a><br /></cfif>
	</cfoutput>
<cfelseif not stObj.bComment>
	<cfoutput>Comments Disabled</cfoutput>
<cfelse><!--- Unpublished --->
	<cfoutput>N/A</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="false" />