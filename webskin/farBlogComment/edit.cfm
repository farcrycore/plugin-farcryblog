<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Edit comment --->
<!--- @@Description: Specific edit handler for a blog comment content item in the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport prefix="ft" taglib="/farcry/core/tags/formtools" />

<!-------------------------------
ACTION:
-------------------------------->
<!--- PERFORM SERVER SIDE VALIDATION --->
<ft:serverSideValidation />

<ft:processForm action="Save" exit="true">
	<ft:processFormObjects typename="#stObj.typename#" />
</ft:processForm>

<ft:processForm action="Cancel" exit="true" />


<!-------------------------------
VIEW:
-------------------------------->
<ft:form>

	<ft:object objectID="#stObj.objectID#" format="edit" lExcludeFields="label" lFields="" legend="Blog Comment" />

	<ft:farcryButtonPanel>
		<ft:farcryButton value="Save" />
		<ft:farcryButton value="Cancel" validate="false" />
	</ft:farcryButtonPanel>

</ft:form>

<cfsetting enablecfoutputonly="false" />