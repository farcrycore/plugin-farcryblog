<cfsetting enablecfoutputonly="true" />
<cfimport prefix="ft" taglib="/farcry/core/tags/formtools" />

<!------------------------------- 
ACTION:
-------------------------------->
<!--- PERFORM SERVER SIDE VALIDATION --->
<ft:serverSideValidation />

<ft:processForm action="Save" Exit="true">
	<ft:processFormObjects typename="#stobj.typename#" />
</ft:processForm>

<ft:processForm action="Cancel" Exit="true" />


<!------------------------------- 
VIEW:
-------------------------------->
<ft:form>

	<ft:object ObjectID="#stobj.ObjectID#" format="edit" lExcludeFields="label,bcaptcha" lFields="" legend="Blog Comment" />
		
	<ft:farcryButtonPanel>
		<ft:farcryButton value="Save" /> 
		<ft:farcryButton value="Cancel" validate="false" />
	</ft:farcryButtonPanel>
	
</ft:form>

<cfsetting enablecfoutputonly="false" />