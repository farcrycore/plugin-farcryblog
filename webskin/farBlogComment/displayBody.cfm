<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Body Layout --->
<!--- @@Description: Standard Body Layout of a blog comment --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfoutput>
	<h1>#stObj.label#</h1>
	<div class="body">#stObj.description#</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />