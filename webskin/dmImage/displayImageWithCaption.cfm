<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Image with Caption --->
<!--- @@Description: Image with caption display used by snag bag full page display for blog posts --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<cfoutput>
<div class="image-caption">
	<img src="#application.url.imageroot##stObj.standardImage#" border="0" alt="#stObj.alt#" title="#stObj.title#" />
	<p>#stObj.title#</p>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false">