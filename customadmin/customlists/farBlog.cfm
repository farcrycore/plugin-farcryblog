<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Manage blog posts --->
<!--- @@Description: Blog post content type administration for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset qBlogs = application.fapi.getContentType(typename="farBlog").getBlogsByCurrentUser() />

<!--- set up page header --->
<admin:header title="Blogs" />

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
	<p>To edit your spam protection setting go to Admin > Edit Config > Spam Protection.</p>
	<h1>Blogs</h1>
	<cfif application.security.checkPermission("blogAdmin")><p><a href="#application.url.webtop#/conjuror/invocation.cfm?objectid=#createuuid()#&typename=farBlog&method=edit&ref=typeadmin&module=customlists/farBlog.cfm&plugin=farcryblog">Add a new blog...</p></cfif>
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