<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Custom edit form --->

<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<ft:processForm action="Save" Exit="true">
	<ft:processFormObjects typename="farBlog" />
	<cfset setLock(objectid=stObj.objectid,locked=false) />
</ft:processForm>

<ft:processForm action="Cancel" Exit="true">
	<cfset setLock(objectid=stObj.objectid,locked=false) />
</ft:processForm>

<admin:header />

<skin:htmlHead library="jqueryjs" />
<skin:htmlHead><cfoutput>
	<script type="text/javascript">
		jQ(function(){
			jOthers = jQ("input[name$=bPublishComments],input[name$=bEmailNotification]");
			function disableOthers(disabled){
				jOthers.attr("disabled",disabled);
			};
			disableOthers(
				jQ("input[name$=bEnableComments]").bind("click",function(){
					disableOthers(this.value==0);
				})
				
				.filter(":checked").val()==0
			);
		});
	</script>
</cfoutput></skin:htmlHead>

<ft:form>
	<ft:object typename="farBlog" ObjectID="#stobj.objectID#" format="edit" lFields="title,tagline,teaser" Legend="Name and Description" />
	
	<ft:object typename="farBlog" ObjectID="#stobj.objectID#" format="edit" lFields="headerImage,teaserImage" Legend="Banner and Images" />
	
	<ft:object typename="farBlog" ObjectID="#stobj.objectID#" format="edit" lFields="email,bEnableComments,bPublishComments,bEmailNotification" Legend="Comments" />
	
	<ft:object typename="farBlog" ObjectID="#stobj.objectID#" format="edit" lFields="aAuthors" Legend="Authors" />
	
	<ft:object typename="farBlog" ObjectID="#stobj.objectID#" format="edit" lFields="lCategories" Legend="Categorisation" />
	
	<ft:farcryButtonPanel>
		<ft:button value="Save" color="orange" /> 
		<ft:button value="Cancel" validate="false" />
	</ft:farcryButtonPanel>
</ft:form>

<admin:footer />

<cfsetting enablecfoutputonly="false" />