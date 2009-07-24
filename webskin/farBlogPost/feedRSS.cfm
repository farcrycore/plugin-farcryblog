<cfsetting enablecfoutputonly="true" /> 
<!--- @@Copyright: Copyright (c) 2008 Daemon Pty Limited. All rights reserved. --->
<!--- @@displayname: RSS Feed --->
<!--- @@description: Type webskin for RSS feed for the latest blog posts. --->
<!--- @@author: Geoffrey Bowers on 2008-12-15 --->
<!--- @@cacheStatus: 1 --->
<!--- @@cacheTimeout: 15 --->

<!--- deactivate the tray --->
<cfset request.mode.ajax = true />

<cfquery datasource="#application.dsn#" name="qPosts">
SELECT TOP 30 objectid, publishDate, teaser, title
FROM farBlogPost
ORDER BY publishDate DESC
</cfquery>

<cfset qFeed = queryNew("title, content, publisheddate, rsslink") />
<cfloop query="qposts">
	<cfset queryaddrow(qFeed, 1) />
	<cfset querysetcell(qFeed, "title", qPosts.title) />
	<cfset querysetcell(qFeed, "content", abbreviate(qPosts.teaser, 300)) />
	<cfset querysetcell(qFeed, "publisheddate", qPosts.publishDate) />
	<cfset querysetcell(qFeed, "rsslink", "http://#cgi.HTTP_HOST#" & application.fapi.getLink(objectid=qPosts.objectid)) />
</cfloop>

<!--- Set the feed metadata. --->
<cfset stprop = StructNew() />
<cfset stprop.title = xmlFormat(application.fapi.getconfig(key="farcryblog", name="blogTitle")) />
<cfset stprop.link = "http://#cgi.HTTP_HOST#/" />
<cfset stprop.description = xmlFormat(application.fapi.getconfig(key="farcryblog", name="blogAbout")) />
<cfset stprop.version = "rss_2.0" />

<!--- Create the feed. --->
<cffeed 
	action="create"
	query="#qFeed#"
	properties="#stProp#"
	xmlvar="rssXML" />

<cfcontent reset="true" /><cfoutput>#rssXML#</cfoutput>


<!---<cfdump var="#XMLParse(rssXML)#">--->

<cfsetting enablecfoutputonly="false" />
