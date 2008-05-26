<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display post permalink --->
<!--- @@Description: Permalink to blog post --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.title#" />

<cfsetting enablecfoutputonly="false" />