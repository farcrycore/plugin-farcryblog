<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Short teaser --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset stLocal.stAuthor = application.fapi.getContentObject(objectid=stObj.dmProfileID,typename="dmProfile") />

<cfoutput>
	<div class="blog-post-teasershort">
		<h2>#stObj.title#</h2>
		<p class="blog-post-author">#stLocal.stAuthor.firstname# #stLocal.stAuthor.lastname#</p>
		<p class="blog-post-teaser">#stObj.teaser# [<skin:buildLink objectid="#stObj.objectid#">Read more</skin:buildLink>]</p>
		<p class="blog-post-meta"><span class="blog-post-publishdate">#dateformat(stObj.publishDate,"dd mmmm yy")#</span> <span class="blog-post-commentcount">Comments (#getTotalComments(objectid=stObj.objectid)#)</span></p>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />