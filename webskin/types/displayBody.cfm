<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Main Body content --->
<!--- @@Description: Standard Main Body Content for all content types --->


<!--- ---- --->
<!--- VIEW --->
<!--- ---- --->
<cfoutput>
<h1>#stobj.label#</h1>
<cfif structKeyExists(stobj, "body")>
	<cfoutput>#stobj.body#</cfoutput>
</cfif>
</cfoutput>

		
<cfsetting enablecfoutputonly="false" />