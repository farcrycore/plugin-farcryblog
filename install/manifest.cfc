<!--- @@Copyright: Daemon Pty Limited 2002-2009, http://www.daemon.com.au --->
<!--- @@License:  --->
<!--- @@displayname: Blog installation manifest --->
<!--- @@Description: Installation manifest for the FarCry Blog plugin --->
<cfcomponent extends="farcry.core.webtop.install.manifest" name="manifest">

<cfset this.name = "FarCry Blog" />
<cfset this.description = "FarCry multiple blogs and multiple authors plugin." />
<cfset this.lRequiredPlugins = "" />
<cfset addSupportedCore(majorVersion="5", minorVersion="0", patchVersion="0") />

</cfcomponent>