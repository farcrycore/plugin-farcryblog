<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Standard landing page --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset stLocal.qPosts = getLatestPosts(objectid=stObj.objectid) />

<cfoutput>
	<div class="blog-header">
		<h1>#stObj.title#</h1>
		<cfif len(stObj.headerImage)>
			<img src="#stObj.headerImage#" class="blog-header-image" alt="" />
		</cfif>
		<cfif len(stObj.tagline)>
			<p class="blog-tagline">#stObj.tagline#</p>
		</cfif>
		<p class="blog-teaser">#stObj.teaser#</p>
	</div>
	<div class="blog-post-list">
		<cfloop query="stLocal.qPosts">
			<div class="blog-post"><skin:view objectid="#stLocal.qPosts.objectid#" webskin="displayTeaserStandard" /></div>
		</cfloop>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />