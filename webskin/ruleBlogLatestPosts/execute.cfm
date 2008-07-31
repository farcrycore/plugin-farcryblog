<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Execute Post Rule --->
<!--- @@Description: Execute webskin for ruleBlogPost, a paginated display of post teasers in reverse order of publication date. --->


<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<cfset oBlog = createObject("component", application.stcoapi["farBlogPost"].packagePath) />
<cfset qRecentPosts = oBlog.getPostsByCategoryList(lCategoryIDs="#stObj.catBlogPost#", maxRows="999") />


<ft:pagination
	paginationID="#arguments.objectID#"
	qRecordset="#qRecentPosts#"
	typename="farBlog"
	pageLinks="10"
	recordsPerPage="#stObj.numberOfPosts#"
	top="false"
	bottom="true"
	submissionType="url"
	renderType="inline"
	>

	<ft:paginateLoop r_stObject="st" bTypeAdmin="false">
		<skin:view objectid="#st.objectid#" webskin="displayTeaserStandard" alternateHTML="No display template found." />
	</ft:paginateLoop>

</ft:pagination>

<cfsetting enablecfoutputonly="false" />