<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2009, http://www.daemon.com.au --->
<!--- @@License:  --->
<!--- @@displayname: Blog Management --->
<!--- @@Description: Blog content type administration for the FarCry Blog plugin --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfif isdefined("url.delete") and len(url.delete)>
	<!--- Delete blog --->
	<cfset oBlog = application.fapi.getContentType(typename="farBlog") />
	<cfset stDeletingObject = oBlog.getData(objectid=url.delete) />
	<cfset stResult = oBlog.delete(objectid=url.delete) />

	<!--- TODO: this should all be in the blog.delete() method --->
	<!--- Delete related posts --->
	<cfquery datasource="#application.dsn#" name="qPosts">
		select		objectID
		from 		#application.dbowner#farBlogPost p
	</cfquery>
	<cfset oPost = application.fapi.getContentType(typename="farBlogPost") />
	<cfloop query="qPosts">
		<cfset oPost.delete(objectid=q.objectid) />
	</cfloop>
	
	<cfif isDefined("stResult.bSuccess") AND not stResult.bSuccess>
		<extjs:bubble title="Error deleting - #stDeletingObject.label#" bAutoHide="true">
			<cfoutput>#stResult.message#</cfoutput>
		</extjs:bubble>
	<cfelse>
		<extjs:bubble title="Deleted - #stDeletingObject.label#, and #qPosts.recordcount# post/s" bAutoHide="false" />
	</cfif>
</cfif>

<cfset qBlogs = application.fapi.getContentType(typename="farBlog").getBlogsByCurrentUser() />

<!--- set up page header --->
<admin:header title="Blog Management" />

<skin:htmlHead><cfoutput>
<style type="text/css">
	table.blog-admin-list { border:0 none; width:100%; border-collapse:separate; border-spacing:5px; }
	td.blog-admin-image { border:0 none; }
	td.blog-admin-manage { border:1px solid ##CCCCCC; }
	td.blog-admin-manage h2 { margin-top:0; float:left; margin-right: 25px; }
	td.blog-admin-settings { }
	.blog-admin-actions { clear:both; margin-top:10px; }
	.blog-admin-actions a { margin-right:25px;}
</style>
</cfoutput></skin:htmlHead>

<cfoutput>
	<h1>Blog Management</h1>
	<cfif application.security.checkPermission("farBlogAdmin")><p><a href="#application.url.webtop#/conjuror/invocation.cfm?objectid=#createuuid()#&typename=farBlog&method=edit&ref=typeadmin&module=customlists/farBlog.cfm&plugin=farcryblog">Add a new blog...</p></cfif>
	<table class="blog-admin-list">
</cfoutput>

<cfloop query="qBlogs">
	<skin:view objectid="#qBlogs.objectid#" typename="farBlog" webskin="adminTeaser" />
</cfloop>

<cfoutput>
	</table>
</cfoutput>

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />