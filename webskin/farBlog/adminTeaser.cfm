<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Admin row --->

<cfset stStats = getAdminStats(objectid=stObj.objectid) />

<cfoutput>
	<tr class="blog-admin">
		<td class="blog-admin-image">
			<cfif len(stObj.teaserImage)>
				<img src="#stObj.teaserImage#" alt="" />
			<cfelse>
				&nbsp;
			</cfif>
		</td>
		<td class="blog-admin-manage">
			<h2>#stObj.title#</h2>
			<cfif application.security.checkPermission(permission="farBlogAdmin") or application.fapi.hasRole("sysadmin")><span class="blog-admin-settings"><a href="#application.url.webtop#/conjuror/invocation.cfm?objectid=#stObj.objectid#&method=edit&ref=typeadmin&module=#url.module#&plugin=#url.plugin#&finishurl=">Edit General Settings</a></span></cfif>
			<div class="blog-admin-actions">
				<a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogPost.cfm&plugin=farcryblog&farBlogID=#stObj.objectid#&status=all">Posts #stStats.all_posts#</a>
				<cfif application.security.checkPermission(type="farBlog",permission="Approve") or application.fapi.hasRole("sysadmin")><a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogPost.cfm&plugin=farcryblog&farBlogID=#stObj.objectid#&status=pending">Posts Awaiting Approval #stStats.pending_posts#</a></cfif>
				<a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogComment.cfm&plugin=farcryblog&farBlogID=#stObj.objectid#&status=all">Comments #stStats.all_comments#</a>
				<cfif not stObj.bPublishComments><a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogComment.cfm&plugin=farcryblog&farBlogID=#stObj.objectid#&status=pending">Comments Awaiting Approval #stStats.pending_comments#</a></cfif>
			</div>
		</td>
	</tr>
</cfoutput>

<cfsetting enablecfoutputonly="false" />