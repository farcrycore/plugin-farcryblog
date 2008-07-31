<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Manage blog categories --->
<!--- @@Description: Blog category content type administration for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- set up page header --->
<admin:header title="Blog Categories" />

<ft:processform action="Change Blog Skin">
	<ft:processformobjects typename="skinSelector" />
</ft:processform>

<cfoutput>
	<h1>Change Blog Skin</h1>
</cfoutput>

<ft:form>
	
	<ft:object typename="skinSelector" lfields="skin" />
	
	<ft:buttonpanel>
		<ft:button value="Change Blog Skin" />
	</ft:buttonpanel>
	
</ft:form>

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />