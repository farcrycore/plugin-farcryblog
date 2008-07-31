<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Category List --->
<!--- @@description: Displays list of Categories assigned to a blog post  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>
<cfset oCat = createObject("component", "farcry.core.packages.types.category") />
<cfset qCategories = getPostCategories(objectid="#stobj.objectid#") />

<cfif qCategories.recordCount>
	<cfloop query="qCategories">
		<cfset catName = oCat.getCategoryNamebyID(categoryid="#qCategories.categoryID#") />
		<skin:buildlink typename="dmCategory" objectid="#qCategories.categoryID#" linktext="#catName#" />
	</cfloop>
</cfif>

<cfsetting enablecfoutputonly="false">