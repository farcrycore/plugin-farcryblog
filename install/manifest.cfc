<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Blog installation manifest --->
<!--- @@Description: Installation manifest for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<cfcomponent extends="farcry.core.webtop.install.manifest" name="manifest">

<cfset this.name = "FarCry Blog" />
<cfset this.description = "FarCry Blog Plugin" />
<cfset this.lRequiredPlugins = "" />
<cfset addSupportedCore(majorVersion="5", minorVersion="0", patchVersion="0") />

</cfcomponent>