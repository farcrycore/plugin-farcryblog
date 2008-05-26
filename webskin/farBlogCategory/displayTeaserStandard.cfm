<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Standard page layout --->
<!--- @@Description: Standard full page display for blog categories --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<cfoutput>
<div class="teaser">
	<h4>#stObj.label#</h4>
	<p>#stObj.description#</p>
	<div></cfoutput>
		<skin:buildLink objectID="#stObj.objectID#"><cfoutput>more...</cfoutput></skin:buildLink>
	<cfoutput>
	</div>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />