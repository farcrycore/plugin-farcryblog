<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Blog Pod Column --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />


<grid:div>	
	<skin:view objectid="#stObj.objectid#" typeName="#stObj.typeName#" webskin="displayBanner" />

	<skin:view typename="farBlog" objectid="#stobj.objectid#" webskin="displayPodSubscribe" />
	
	<skin:view typename="farBlog" objectid="#stobj.objectid#" webskin="displayPodTellYourFriends" />
	
	<skin:view typename="farBlog" objectid="#stobj.objectid#" webskin="displayPodBlogCategories" />
	
	<skin:view typename="farBlogComment" webskin="displayTypePodLatestComments" />
	
	<skin:view typename="farBlogPost" webskin="displayTypePodRecentPosts" />
	
	<skin:view typename="farBlogPost" webskin="displayTypePodMostPopular" />
	
	<skin:view typename="farBlog" webskin="displayTypePodRelatedSites" />
	
	<skin:view typename="farBlog" webskin="displayTypePodLatestEntries" />		
</grid:div>

			






<cfsetting enablecfoutputonly="false" />