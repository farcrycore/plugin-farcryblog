<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Latest Comments --->
<!--- @@Description:  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfparam name="stParams.num" default="5" />

<cfset qLatestComments = getRecentComments(stParams.num) />

<cfoutput>
<div class="blog-pod">
	<h3>Latest Comments</h3>
	<cfloop query="qLatestComments">
		<skin:view typename="farBlogComment" objectid="#qLatestComments.objectid#" webskin="displayTeaserPod" />
	</cfloop>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />