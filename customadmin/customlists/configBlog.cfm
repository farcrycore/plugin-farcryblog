
<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Redirect to the blog config --->
<!--- @@description:   --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>

<cfquery datasource="#application.dsn#" name="qConfig">
	select	objectid
	from	#application.dbowner#farConfig
	where	configkey=<cfqueryparam cfsqltype="cf_sql_varchar" value="farcryblog" />
</cfquery>

<skin:location url="/webtop/conjuror/invocation.cfm?objectid=#qConfig.objectid[1]#&typename=farConfig&method=edit&ref=typeadmin&module=customlists/configBlog.cfm&amp;plugin=farcryblog" />

<cfsetting enablecfoutputonly="false">