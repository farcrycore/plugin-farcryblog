<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2009, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Execute Post Rule --->
<!--- @@Description: Execute webskin for ruleBlogPost, a paginated display of post teasers in reverse order of publication date. --->

<!--- @@cacheStatus: 1 --->
<!--- @@cacheTypeWatch: farBlogPost --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<cfset oBlog = application.fapi.getContentType("farBlogPost") />
<cfset qRecentPosts = oBlog.getPostsByCategoryList(lCategoryIDs="#stObj.catBlogPost#", maxRows="999") />


		<ft:form>	
			<skin:pagination 
				paginationID="latestNews"
				qRecordSet="#qRecentPosts#"
				typename="farBlogPost"
				pageLinks="10"
				recordsPerPage="#stObj.numberOfPosts#" 
				Top="false" 
				Bottom="true"
				renderType="inline" r_stObject="stNews"> 
					<skin:view objectid="#stNews.objectid#" typename="farBlogPost" webskin="displayTeaserStandard" />
			</skin:pagination>
		</ft:form>	

<cfsetting enablecfoutputonly="false" />