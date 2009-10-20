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
<cfparam name="url.farBlogID" /><!--- Required --->
<cfparam name="url.status" default="all" /><!--- Which posts to show --->

<cfset stBlog = application.fapi.getContentObject(objectid=url.farBlogID,typename="farBlog") />

<cfif url.status eq "all">
	<cfset sqlWhere = "farBlogID='#url.farBlogID#'" />
<cfelse>
	<cfset sqlWhere = "farBlogID='#url.farBlogID#' and status in (#listqualify(url.status,'''')#)" />
</cfif>

<!--- set up page header --->
<admin:header title="Blog Posts" />

<ft:objectAdmin
	title="#stBlog.title# Blog Posts"
	typename="farBlogPost"
	columnList="title,publishDate,bComment,bAutoPublish"
	sortableColumns="title,publishDate"
	lFilterFields="title"
	sqlOrderBy="publishDate DESC"
	sqlWhere="#sqlWhere#"
	module="#urlencodedformat('customlists/farBlogPost.cfm&farBlogID=#url.farBlogID#&status=#url.status#')#"
	plugin="farcryblog" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />