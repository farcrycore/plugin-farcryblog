<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Standard landing page --->
<!--- @@fuAlias: CatFilter --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />

<!--- ENVIRONMENT VARIABLES --->
<cfparam name="url.cat" default="" />

<cfif len(url.cat) AND NOT listFindNoCase(stobj.lCategories,url.cat)>
	<cfset url.cat = "" />
</cfif>

<cfset stLocal.qPosts = getLatestPosts(objectid=stObj.objectid, category=url.cat) />


<grid:div style="float:left;width:25%;">
	<skin:view objectid="#stObj.objectid#" typeName="#stObj.typeName#" webskin="displayPodColumn" />
</grid:div>

<grid:div style="float:left;width:75%;">
	<grid:div style="padding:5px;">	
		
		
		<cfif len(url.cat)>
			<cfoutput>
				<h1>Blog Category Listing (#url.cat#)</h1>
				<div class="blog-post-list">
					<skin:pagination query=stLocal.qPosts recordsPerPage=10 r_stObject="stCurrentBlogPost">
						<div class="blog-post"><skin:view objectid="#stCurrentBlogPost.objectid#" typename="farBlogPost" webskin="displayTeaserStandard" /></div>
					</skin:pagination>
				</div>
			</cfoutput>
		<cfelse>
			<cfoutput>
				<h1>Blog Category Listing</h1>
				<p>You have selected an invalid category.</p>
			</cfoutput>
		</cfif>
	</grid:div>
</grid:div>

			






<cfsetting enablecfoutputonly="false" />