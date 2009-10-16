<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Standard teaser --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset stLocal.stAuthor = application.fapi.getContentObject(objectid=stObj.dmProfileID,typename="dmProfile") />
<cfset stLocal.qCategories = getPostCategories(objectid=stObj.objectid) />

<cfoutput>
	<div class="blog-post-teaserstandard">
		<h2>#stObj.title#</h2>
		<p class="blog-post-tagline">
			<span class="blog-post-author">By #stLocal.stAuthor.firstname# #stLocal.stAuthor.lastname#</span>
			<span class="blog-post-publishdate">#dateformat(stObj.publishDate,"ddd, dd mmmm yyyy")#</span>
		</p>
		<p class="blog-post-teaser">#stObj.teaser# [<skin:buildLink objectid="#stObj.objectid#">Read more</skin:buildLink>]</p>
		<p class="blog-post-categories">
			<cfloop query="stLocal.qCategories">
				<skin:buildLink objectid="#stLocal.qCategories.categoryid#">#stLocal.qCategories.categoryLabel#</skin:buildLink>
			</cfloop>
		</p>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />