<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Blog Post Listing --->
<!--- @@author: Geoff Bowers --->
<!--- @@hashURL: true --->


<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />

<!--- data providers --->
<cfset sqlWhere = "status = 'approved'" />
<cfset sqlorderby = "publishdate desc" />
<cfset formToolsUtilsObj = CreateObject("component","#application.packagepath#.farcry.formTools") />
<cfset stRecordset = structNew() />	
<cfset arStObject = structNew() />
<cfset o = createobject("component", application.types['farblogpost'].typepath ) />
<cfset lFilterCategories = stobj.catblogpost />


<!--- getRecordset requires url.page --->
<cfset stRecordset = formToolsUtilsObj.getRecordset(
		paginationID="#arguments.objectid#", 
		sqlColumns="*", 
		typename="farBlogPost", 
		RecordsPerPage="#stobj.numberofposts#", 
		sqlOrderBy="#sqlorderby#", 
		sqlWhere="#sqlWhere#", 
		lCategories="#lFilterCategories#") />	


<ft:form>
	<ft:pagination 
		paginationID="#arguments.objectid#"
		qRecordSet="#stRecordset.q#"
		typename="#stRecordset.typename#"
		totalRecords="#stRecordset.countAll#" 
		currentPage="#stRecordset.currentPage#"
		pageLinks="5"
		recordsPerPage="#stRecordset.recordsPerPage#" 
		Top="false" 
		Bottom="true"
		submissionType="url"
		scrollPrefix="<div id=""pagination"">"
		scrollSuffix="</div>"
		>

		<ft:paginateLoop r_stObject="st" bTypeAdmin="false">		
			<cfset HTML = o.getView(stObject=st.stobject, template="displayTeaserStandard", alternateHTML="No display template found.") />
			<cfoutput>#HTML#</cfoutput>
		</ft:paginateLoop>

	</ft:pagination> 
</ft:form>

<cfsetting enablecfoutputonly="false" />