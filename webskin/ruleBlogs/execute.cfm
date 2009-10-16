<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Execute blog list rule --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfoutput><div class="blog-list"></cfoutput>

<cfloop from="1" to="#arraylen(stObj.aBlogs)#" index="stLocal.i">
	<skin:view objectid="#stObj.aBlogs[stLocal.i]#" webskin="#stObj.displayMethod#" />
</cfloop>

<cfoutput></div></cfoutput>

<cfsetting enablecfoutputonly="false" />