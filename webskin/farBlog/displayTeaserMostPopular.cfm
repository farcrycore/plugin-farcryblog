<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Teaser with most popular post --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset stLocal.stLatestPost = getLatestPost(objectid=stObj.objectid) />

<cfoutput>
	<div class="post">
		<div class="blog-details">
			<h2><skin:buildLink objectid="#stObj.objectid#">#stObj.title#</skin:buildLink></h2>
			<cfif len(stObj.teaserImage)>
				<img src="#stObj.teaserImage#" class="blog-teaser-image" alt="" />
			</cfif>
			<p class="blog-teaser">#stObj.teaser#</p>
		</div>
		<div class="blog-post">
			<cfif structisempty(stLocal.stLatestPost)>
				<p>No posts yet</p>
			<cfelse>
				<skin:view stObject="#stLocal.stLatestPost#" webskin="displayTeaserShort" />
			</cfif>
		</div>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />