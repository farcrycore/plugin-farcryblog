<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Standard page layout --->
<!--- @@Description: Standard full page display for blog categories --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayHeaderStandard" pageTitle="#stObj.label#" />

<cfoutput>
<div class="item">
	<div class="content">
		<h1></cfoutput><skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.label#" /><cfoutput></h1>
		<div class="body">#stObj.description#</div>
	</div>
</div>
</cfoutput>

<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayFooterStandard" />

<cfsetting enablecfoutputonly="false" />