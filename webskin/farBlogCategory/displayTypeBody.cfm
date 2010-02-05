<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Category List --->
<!--- @@description: Displays list of Categories assigned to a blog post  --->

<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfparam name="stParam.blogID" default="" />
<cfparam name="stParam.postID" default="" />

<cfset qCategories = getCategories(postID=stParam.postID,blogID=stParam.blogID) />

<cfif qCategories.recordCount>

	<cfoutput>
		<ul>
			</cfoutput>
	
			<cfloop query="qCategories">
				<skin:buildLink bodyView="displayTypeBodyByCategory" type="farBlogPost" urlParameters="cat=#qCategories.objectID#&blog=#stParam.blogID#">
					<cfoutput><li>#title# <cfif NOT len(stParam.postID)>(#total#)</cfif></li></cfoutput>
				</skin:buildLink>
			</cfloop>
	
			<cfoutput>
		</ul>
	</cfoutput>
	
</cfif>

<cfsetting enablecfoutputonly="false">