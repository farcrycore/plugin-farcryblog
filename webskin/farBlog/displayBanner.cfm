<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Blog banner strip --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfoutput>
	<div class="blog-header">
		
		<h2>
			<skin:buildLink objectid="#stObj.objectid#" typename="#stObj.typeName#">#stObj.title#</skin:buildLink>
		</h2>
		<cfif len(stObj.headerImage)>
			<img src="#stObj.headerImage#" class="blog-header-image" alt="#stObj.title#" />
		</cfif>
		<cfif len(stObj.tagline)>
			<p class="blog-tagline">#stObj.tagline#</p>
		</cfif>
		<p class="blog-teaser">#stObj.teaser#</p>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />