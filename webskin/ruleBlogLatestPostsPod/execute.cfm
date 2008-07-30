<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Execute --->
<!--- @@Description: Execute webskin for ruleLatestBlogPostsPod. --->


<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- data providers --->
<cfset qRecentPosts = createObject("component", application.stcoapi["farBlogPost"].packagePath).getRecentPosts(maxRows="#stobj.numberOfPosts#") />


<cfoutput>
<div>
	<h3>Recent Posts</h3>
	<ul>
</cfoutput>

<cfloop query="qRecentPosts">
	<skin:view typename="farBlogPost" objectid="#qRecentPosts.objectid#" webskin="displayLink" r_html="htmlLink" />
	<cfoutput><li>#htmlLink#</li></cfoutput>
</cfloop>

<cfoutput>
	</ul>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />