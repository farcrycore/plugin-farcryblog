<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Title/Link with Author --->
<!--- @@Description: Display blog comment subject and link. --->
<!--- @@Developer: Geoff Bowers (modius@daemon.com.au) --->

<!--- import tag library --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfoutput>#stobj.commenthandle# on <skin:buildlink objectid="#stobj.parentid#" linktext="#stobj.subject#" /></cfoutput>

<cfsetting enablecfoutputonly="false" />