<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Standard page layout --->
<!--- @@Description: Standard full page display for blog categories --->


<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/plugins/farcryblog/tags/" prefix="blog" />


<cfoutput>
<h2 class="title">Archive for the '#stobj.categoryLabel#' Category</h2>
<!--- <p>#stobj.description#</p> --->
</cfoutput>

<cfset qCategoryBlogPosts = createObject("component", application.stcoapi["farBlogPost"].packagePath).getPostsByCategory(categoryid=stobj.objectid) />
<ft:pagination
	paginationID="#arguments.objectID#"
	qRecordSet="#qCategoryBlogPosts#"
	typename="farBlogPost"
	pageLinks="5"
	recordsPerPage="2"
	top="true"
	bottom="true"
	submissionType="url" 
	renderType="inline" >

	<ft:paginateLoop r_stObject="st" bTypeAdmin="false">
		<skin:view typename="farBlogPost" objectid="#st.objectid#" webskin="displayTeaserArchive" />
	</ft:paginateLoop>
</ft:pagination>


<cfsetting enablecfoutputonly="false" />