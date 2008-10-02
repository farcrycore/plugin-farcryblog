<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: @LICENSE@ --->
<!--- @@displayname: Manage blog categories --->
<!--- @@Description: Blog category content type administration for the FarCry Blog plugin --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- set up page header --->
<admin:header title="Blog Categories" />

<ft:processform action="Change Blog Skin" url="refresh">
	<ft:processformobjects typename="skinSelector" />
</ft:processform>

<cfoutput>
	<h1>Change Blog Skin</h1>
</cfoutput>

<ft:form>
	
	<ft:object typename="skinSelector" lfields="skin,bDirectories" />
	
	<ft:buttonPanel>
		<ft:button value="Change Blog Skin" />
	</ft:buttonPanel>
	
</ft:form>

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />