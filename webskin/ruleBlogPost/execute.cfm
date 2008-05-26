<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Blog: Execute Post Rule --->
<!--- @@Description: Execute webskin for ruleBlogPost, a paginated display of post teasers in reverse order of publication date. --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->
<!--- @@hashURL: true --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- data providers --->
<cfset sqlWhere = "status = 'approved'" />
<cfset sqlOrderBy = "publishDate DESC" />
<cfset oFormtoolUtil = createObject("component", "farcry.core.packages.farcry.formtools") />
<cfset oBlogCategory = createObject("component", application.stCOAPI["farBlogCategory"].packagepath) />
<cfset stRecordset = structnew() />

<!--- filter on blog categories if selected --->
<cfif arraylen(stObj.aCategories)>
	<cfset qCategoryPosts = oBlogCategory.getPostsByCategoryList(arraytolist(stObj.aCategories)) />
	<cfset lCategoryPosts = listqualify(valuelist(qCategoryPosts.objectID),"'",",") />
	<cfif len(lCategoryPosts)>
		<cfset sqlWhere = sqlWhere & " AND objectID IN (#lCategoryPosts#)" />
	<cfelse>
		<cfset sqlWhere = "0 = 1" />
	</cfif>
</cfif>

<!--- retrieve a paginated recordset --->
<cfset stRecordset = oFormtoolUtil.getRecordset(
		paginationID="#arguments.objectID#",
		sqlColumns="*",
		typename="farBlogPost",
		recordsPerPage="#stObj.numberOfPosts#",
		sqlOrderBy="#sqlOrderBy#",
		sqlWhere="#sqlWhere#") />

<ft:pagination
	paginationID="#arguments.objectID#"
	qRecordset="#stRecordset.q#"
	typename="#stRecordset.typename#"
	totalRecords="#stRecordset.countAll#"
	currentPage="#stRecordset.currentPage#"
	pageLinks="5"
	recordsPerPage="#stRecordset.recordsPerPage#"
	top="false"
	bottom="true"
	submissionType="url"
	scrollPrefix="<div id=""pagination"">"
	scrollSuffix="</div>"
	>

	<ft:paginateLoop r_stObject="st" bTypeAdmin="false">
		<skin:view stObject="#st.stObject#" webskin="displayTeaserStandard" alternateHTML="No display template found." />
	</ft:paginateLoop>

</ft:pagination>

<cfsetting enablecfoutputonly="false" />