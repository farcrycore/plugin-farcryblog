<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Manage blog categories --->
<!--- @@Description: Blog category content type administration for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- set up page header --->
<admin:header title="Blog Feeds" />

<ft:objectAdmin
	title="Blog Feeds"
	typename="farWebfeed"
	columnList="title,dateproperty"
	sortableColumns="title,dateproperty"
	lFilterFields="title"
	sqlOrderBy="dateproperty DESC"	
	sqlWhere="itemtype = 'farBlogPost'"
	plugin="farcryblog"
	module="listwebfeed.cfm" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />