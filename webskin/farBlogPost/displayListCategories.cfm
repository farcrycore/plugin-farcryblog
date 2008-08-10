<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Category List --->
<!--- @@description: Displays list of Categories assigned to a blog post  --->

<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>
<cfset oCat = createObject("component", "farcry.core.packages.types.category") />
<cfset qCategories = getPostCategories(objectid="#stobj.objectid#") />

<cfif qCategories.recordCount>
	<cfloop query="qCategories">
		<cfset catName = oCat.getCategoryNamebyID(categoryid="#qCategories.categoryID#") />
		<skin:buildlink typename="dmCategory" objectid="#qCategories.categoryID#" linktext="#catName#" /><cfoutput>, </cfoutput>
	</cfloop>
</cfif>

<cfsetting enablecfoutputonly="false">