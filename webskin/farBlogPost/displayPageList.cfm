<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display post list page --->
<!--- @@Description: Type webskin for farBlogPost, a paginated display of post teasers in reverse order of publication date. --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->
<!--- @@hashURL: true --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- data providers --->
<cfset sqlWhere = "status = 'approved'" />
<cfset sqlOrderBy = "publishDate DESC" />
<cfset oFormtoolUtil = createObject("component", "farcry.core.packages.farcry.formtools") />
<cfset stRecordset = structnew() />

<!--- getRecordset requires url.page --->
<cfset stRecordset = oFormtoolUtil.getRecordset(
		paginationID="#arguments.objectID#",
		sqlColumns="*",
		typename="farBlogPost",
		recordsPerPage="#application.config.farcryblog.postsPerPage#",
		sqlOrderBy="#sqlOrderBy#",
		sqlWhere="#sqlWhere#") />

<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayHeaderStandard" pageTitle="#stObj.title#" />

<ft:pagination
	paginationID="#arguments.objectID#"
	qRecordSet="#stRecordset.q#"
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

<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayFooterStandard" />

<cfsetting enablecfoutputonly="false" />