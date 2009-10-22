<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Standard landing page --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />

<!--- ENVIRONMENT VARIABLES --->

<cfset stLocal.qPosts = getLatestPosts(objectid=stObj.objectid) />


<grid:div style="float:left;width:25%;">
	<skin:view objectid="#stObj.objectid#" typeName="#stObj.typeName#" webskin="displayPodColumn" />
</grid:div>

<grid:div style="float:left;width:75%;">
	<grid:div style="padding:5px;">	
		
		<cfoutput>
			<div class="blog-post-list">
				<skin:pagination query=stLocal.qPosts recordsPerPage=10 r_stObject="stCurrentBlogPost">
					<div class="blog-post"><skin:view objectid="#stCurrentBlogPost.objectid#" typename="farBlogPost" webskin="displayTeaserStandard" /></div>
				</skin:pagination>
			</div>
		</cfoutput>
	</grid:div>
</grid:div>

			






<cfsetting enablecfoutputonly="false" />