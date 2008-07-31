<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Manage blog comments --->
<!--- @@Description: Blog comment content type administration for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- set up page header --->
<admin:header title="Blog Comments" />

<ft:objectAdmin
	title="Blog Comments"
	typename="farBlogComment"
	columnList="label,commentHandle,email,website,parentID,dateTimeCreated"
	sortableColumns="subject,commentHandle,email,website,parentID,dateTimeCreated"
	lFilterFields="subject,commentHandle,email,website"
	sqlOrderBy="dateTimeCreated DESC"
	plugin="farcryblog"
	module="listblogcomment.cfm" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />