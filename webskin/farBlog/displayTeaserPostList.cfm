<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Teaser with 5 most recent posts --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset stLocal.qPosts = getLatestPosts(objectid=stObj.objectid,maxposts=5) />

<cfoutput>
	<div class="blog">
		<div class="blog-details">
			<h2><skin:buildLink objectid="#stObj.objectid#">#stObj.title#</skin:buildLink></h2>
			<cfif len(stObj.teaserImage)>
				<img src="#stObj.teaserImage#" class="blog-teaser-image" alt="" />
			</cfif>
			<p class="blog-teaser">#stObj.teaser#</p>
		</div>
		<div class="blog-post">
			<cfif stLocal.qPosts.recordcount>
				<ul>
				<cfloop query="stLocal.qPosts">
					<li><skin:buildLink objectid="#stLocal.qPosts.objectid#">#stLocal.qPosts.title#</skin:buildLink></li>
				</cfloop>
				</ul>
			<cfelse>
				<p>No posts yet</p>
			</cfif>
		</div>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />