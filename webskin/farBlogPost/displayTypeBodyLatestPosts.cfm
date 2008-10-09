<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Latest Blog Posts --->
<!--- @@description:   --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>

<!--- import tag libraries --->

<cfset qRecentPosts = getRecentPosts(maxRows="999") />


<ft:pagination
	paginationID="#arguments.objectID#"
	qRecordset="#qRecentPosts#"
	typename="farBlogPost"
	pageLinks="10"
	recordsPerPage="20"
	top="false"
	bottom="true"
	submissionType="url"
	renderType="inline"
	>

	<ft:paginateLoop r_stObject="st" bTypeAdmin="false">
		<skin:view objectid="#st.objectid#" webskin="displayTeaserStandard" alternateHTML="No display template found." />
	</ft:paginateLoop>

</ft:pagination>

<cfsetting enablecfoutputonly="false">