<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Load SWF Object Library --->
<!--- @@description: Loads SWF object JS libraries for displaying Flash content.  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfif thisTag.executionMode EQ "end">
	<cfsetting enablecfoutputonly="false">
	<cfexit method="exittag" />
</cfif>

<skin:htmlHead id="swfobject">
<cfoutput>
<!-- swfobject activation code -->
<script type="text/javascript" src="#application.url.webroot#/webtop/js/swfobject.js"></script>
<!--- <script type="text/javascript" src="#application.url.webroot#/farcryblog/js/swfobject/swfobject.js"></script> --->
</cfoutput>
</skin:htmlHead>

<cfsetting enablecfoutputonly="false" />