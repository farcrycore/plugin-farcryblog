<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Manage blog posts --->
<!--- @@Description: Blog post content type administration for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- set up page header --->
<admin:header title="Blogs" />

<ft:objectAdmin
	title="Blogs"
	typename="farBlog"
	columnList="title"
	sortableColumns="title"
	lFilterFields="title"
	sqlOrderBy="title asc"
	plugin="farcryblog" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />