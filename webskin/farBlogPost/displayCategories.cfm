<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Category List --->
<!--- @@description: Displays list of Categories assigned to a blog post  --->

<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset oBlogCat = application.fapi.getContentType("farBlogCategory") />

<cfoutput>
	<ul>
		</cfoutput>

		<cfloop array="#stObj.aCategories#" index="objectID">
			<cfset stCategory = oBlogCat.getData(objectID) />

			<skin:buildLink objectID="#objectID#">
				<cfoutput><li>#stCategory.title#</li></cfoutput>
			</skin:buildLink>
		
		</cfloop>

		<cfoutput>
	</ul>
</cfoutput>

<cfsetting enablecfoutputonly="false">