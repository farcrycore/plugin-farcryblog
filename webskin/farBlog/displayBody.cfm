<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Standard landing page --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset stLocal.qPosts = getLatestPosts(objectid=stObj.objectid) />

<skin:view objectid="#stObj.objectid#" typeName="#stObj.typeName#" webskin="displayBanner" />
			
<cfoutput>
	<div class="blog-post-list">
		<skin:pagination query=stLocal.qPosts recordsPerPage=1 r_stObject="stCurrentBlogPost">
			<div class="blog-post"><skin:view objectid="#stCurrentBlogPost.objectid#" typename="farBlogPost" webskin="displayTeaserStandard" /></div>
		</skin:pagination>
	</div>
</cfoutput>



<skin:view typename="farBlog" objectid="#stobj.objectid#" webskin="displayPodSubscribe" />

<skin:view typename="farBlog" objectid="#stobj.objectid#" webskin="displayPodTellYourFriends" />

<skin:view typename="farBlog" objectid="#stobj.objectid#" webskin="displayTypePodBlogCategories" />

<skin:view typename="farBlogComment" webskin="displayTypePodLatestComments" />

<skin:view typename="farBlogPost" webskin="displayTypePodRecentPosts" />

<skin:view typename="farBlogPost" webskin="displayTypePodMostPopular" />

<skin:view typename="farBlog" webskin="displayTypePodRelatedLinks" />

<skin:view typename="farBlog" webskin="displayTypePodLatestEntries" />


<cfsetting enablecfoutputonly="false" />