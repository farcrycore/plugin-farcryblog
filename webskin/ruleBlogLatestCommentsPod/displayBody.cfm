<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: ruleBlogLatestCommentsPod Display Body --->
<!--- @@Description: Default farcryblog display body webskin for ruleBlogLatestCommentsPod. --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- required params --->
<cfparam name="stparam.qRecentComments" type="query" />

<cfoutput>
<div>
	<h3>Latest Comments</h3>
	<ul>
</cfoutput>

	<cfloop query="stparam.qRecentComments">
		<skin:view typename="farBlogComment" objectid="#stparam.qRecentComments.objectid#" webskin="displayLink" r_html="htmlLink" />
		<cfoutput><li>#htmlLink#</li></cfoutput>
	</cfloop>

<cfoutput>
	</ul>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />