<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display post footer --->
<!--- @@Description: Shared footer for blog post full page displays --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfquery datasource="#application.dsn#" name="qComments">
SELECT COUNT(*) AS total
FROM farBlogComment
WHERE parentID = <cfqueryparam value="#stObj.objectID#" cfsqltype="cf_sql_idstamp">
</cfquery>

<cfoutput>
<p>#application.config.farcryblog.authorName# : Comments (#qComments.total#) : </cfoutput><skin:buildlink objectID="#stObj.objectID#" linktext="permalink" /><cfoutput></p>
</cfoutput>

<cfsetting enablecfoutputonly="false" />