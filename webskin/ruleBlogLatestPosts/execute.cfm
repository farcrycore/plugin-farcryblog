<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2009, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Execute Post Rule --->
<!--- @@Description: Execute webskin for ruleBlogPost, a paginated display of post teasers in reverse order of publication date. --->


<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<cfset oBlog = application.fapi.getContentType("farBlogPost") />
<cfset qRecentPosts = oBlog.getPostsByCategoryList(lCategoryIDs="#stObj.catBlogPost#", maxRows="999") />


<skin:pagination qrecordset="#qRecentPosts#" recordsPerPage="#stObj.numberOfPosts#">
	<skin:view typename="farBlogPost" objectid="#stobject.objectid#" webskin="displayTeaserStandard" />
</skin:pagination>

<cfsetting enablecfoutputonly="false" />