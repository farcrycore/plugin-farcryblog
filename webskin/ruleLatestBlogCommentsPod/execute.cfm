<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Execute --->
<!--- @@Description: Execute webskin for ruleLatestBlogPostsPod. --->


<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- data providers --->
<cfset qRecentComments = createObject("component", application.stcoapi["farBlogComment"].packagePath).getRecentComments(maxRows="#stobj.numberOfComments#") />


<cfoutput>
<h3>Latest Comments</h3>
<ul>
</cfoutput>

<cfloop query="qRecentComments">
	<skin:view typename="farBlogComment" objectid="#qRecentComments.objectid#" webskin="displayLink" r_html="htmlLink" />
	<cfoutput><li>#htmlLink#</li></cfoutput>
</cfloop>

<cfoutput>
</ul>
</cfoutput>

<cfsetting enablecfoutputonly="false" />