<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Manage blog posts --->
<!--- @@Description: Blog post content type administration for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- Admin page parameters --->
<cfif isdefined("session.farBlogPostListBlog")>
	<cfparam name="url.farBlogID" default="#session.farBlogPostListBlog#" /><!--- Required --->
<cfelse>
	<cfparam name="url.farBlogID" /><!--- Required --->
</cfif>
<cfset session.farBlogPostListBlog = url.farBlogID />
<cfparam name="url.status" default="all" /><!--- Which posts to show --->

<cfset stBlog = application.fapi.getContentObject(objectid=url.farBlogID,typename="farBlog") />

<ft:processform action="Add">
	<cfset oPost = application.fapi.getContentType(typename="farBlogPost") />
	<cfset stNew = oPost.getData(objectid=createuuid()) />
	<cfset stNew.farBlogID = url.farBlogID />
	<cfset stNew.dmProfileID = session.dmProfile.objectid />
	<cfset stNew.email = stBlog.email />
	<cfif not listcontains(stNew.email,session.dmProfile.emailaddress)>
		<cfset stNew.email = listappend(stNew.email,session.dmProfile.emailaddress) />
	</cfif>
	<cfset stNew.bComments = stBlog.bEnableComments />
	<cfset stNew.bAutoPublish = stBlog.bPublishComments />
	<cfset stNew.bEmailNotification = stBlog.bEmailNotification />
	<cfset oPost.setData(stProperties=stNew,bSessionOnly=true) />
	<cflocation url="#application.url.webtop#/conjuror/invocation.cfm?objectid=#stNew.objectid#&method=edit&ref=typeadmin&module=#url.module#&plugin=#url.plugin#&finishurl=" addtoken="false" />
</ft:processform>

<cfswitch expression="#url.status#">
	<cfcase value="all">
		<cfset sqlWhere = "farBlogID='#url.farBlogID#'" />
		<cfset adminTitle = "All #stBlog.title# Blog Posts" />
	</cfcase>
	<cfcase value="draft">
		<cfset sqlWhere = "farBlogID='#url.farBlogID#' and status in (#listqualify(url.status,'''')#)" />
		<cfset adminTitle = "Draft #stBlog.title# Blog Posts" />
	</cfcase>
	<cfcase value="pending">
		<cfset sqlWhere = "farBlogID='#url.farBlogID#' and (status in (#listqualify(url.status,'''')#) or objectid in (select versionID from #application.dbowner#farBlogPost where status in (#listqualify(url.status,'''')#)))" />
		<cfset adminTitle = "Pending #stBlog.title# Blog Posts" />
	</cfcase>
	<cfcase value="approved">
		<cfset sqlWhere = "farBlogID='#url.farBlogID#' and (status in (#listqualify(url.status,'''')#) or objectid in (select versionID from #application.dbowner#farBlogPost where status in (#listqualify(url.status,'''')#)))" />
		<cfset adminTitle = "Approved #stBlog.title# Blog Posts" />
	</cfcase>
</cfswitch>

<cfset aCustomColumns = arraynew(1) />

<cfset stCol = structnew() />
<cfset stCol.webskin = "cellDate" />
<cfset stCol.heading = "Dates" />
<cfset arrayappend(aCustomColumns,stCol) />

<cfset arrayappend(aCustomColumns,"title") />

<cfset stCategories = structnew() />
<cfset stCategories.title = "Categories" />
<cfset stCategories.webskin = "displayCategoryAdmin" />
<cfset stCategories.sortable = false />
<cfset stCategories.property = "aCategories" />

<cfset arrayappend(aCustomColumns,stCategories) />


<cfset stCol = structnew() />
<cfset stCol.webskin = "cellComments" />
<cfset stCol.heading = "Comments" />
<cfset arrayappend(aCustomColumns,stCol) />

<cfset arrayappend(aCustomColumns,"dmProfileID") />

<!--- set up page header --->
<admin:header title="Blog Posts" />

<cfoutput><p><a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlog.cfm&plugin=farcryblog">Return to Blogs</a></p></cfoutput>

<ft:objectAdmin
	title="#adminTitle#"
	typename="farBlogPost"
	columnList="publishDate,title,dmProfileID"
	aCustomColumns="#aCustomColumns#"
	sortableColumns="title"
	lFilterFields="title"
	sqlOrderBy="publishDate DESC"
	sqlWhere="#sqlWhere#"
	module="#urlencodedformat('customlists/farBlogPost.cfm&farBlogID=#url.farBlogID#&status=#url.status#')#"
	plugin="farcryblog" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />