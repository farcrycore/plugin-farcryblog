<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Custom edit form --->

<cfimport taglib="/farcry/core/tags/admin" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<ft:processForm action="Save" Exit="true">
	<ft:processFormObjects typename="farBlogPost" />
	<cfset setLock(objectid=stObj.objectid,locked=false) />
</ft:processForm>

<ft:processForm action="Cancel" Exit="true">
	<cfset setLock(objectid=stObj.objectid,locked=false) />
</ft:processForm>

<admin:header />

<ft:form>
	<ft:object typename="farBlogPost" ObjectID="#stobj.objectID#" format="edit" lFields="title" Legend="Name and Description" />
	<cfif application.fc.factory.farFU.isUsingFU()>
		<cfset qFUs = application.fc.factory.farFU.getFUList(objectID="#stobj.objectid#", fuStatus="current")>
		<cfoutput>
		<div class="fieldSection fu">
			<label class="fieldsectionlabel " for="fc1D7AA5A0BDDE11DE918B001FD08AA651fu"> Friendly URLs </label>
			<div class="fieldAlign">
				<cfloop query="qFUs">#qFUs.friendlyURL#<br /></cfloop><a href='#application.url.farcry#/manage_friendlyurl.cfm?objectid=#stobj.objectid#' target='_blank'>Edit</a>
			</div>
			<br class="clearer"/>
		</div>
		</cfoutput>
	</cfif>
	<ft:object typename="farBlogPost" ObjectID="#stobj.objectID#" format="edit" lFields="publishdate,displayname,email,bComments,bAutoPublish,bEmailNotification" IncludeFieldSet="false" />
	
	
	<ft:object typename="farBlogPost" ObjectID="#stobj.objectID#" format="edit" lFields="body,teaser,teaserImage,catBlogPost,lCategories" Legend="Copy" />
	
	<ft:object typename="farBlogPost" ObjectID="#stobj.objectID#" format="edit" lFields="aObjectIDs,wddxRelatedLinks,aRelatedPosts" Legend="Relationships" />
	
	<ft:object typename="farBlogPost" ObjectID="#stobj.objectID#" format="edit" lFields="aMedia" Legend="Media/Related Images" />
	
	<ft:farcryButtonPanel>
		<ft:button value="Save" color="orange" /> 
		<ft:button value="Cancel" validate="false" />
	</ft:farcryButtonPanel>
</ft:form>

<admin:footer />

<cfsetting enablecfoutputonly="false" />