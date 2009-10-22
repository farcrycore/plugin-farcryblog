<cfsetting enablecfoutputonly="true" /> 
<!--- @@Copyright: Copyright (c) 2008 Daemon Pty Limited. All rights reserved. --->
<!--- @@displayname: RSS Feed --->
<!--- @@description: Type webskin for RSS feed for the latest blog posts. --->
<!--- @@author: Geoffrey Bowers on 2008-12-15 --->
<!--- @@cacheStatus: 1 --->
<!--- @@cacheTimeout: 15 --->
<!--- @@fuAlias: rss --->

<!--- deactivate the tray --->
<cfset request.mode.ajax = true />

<cfquery datasource="#application.dsn#" name="qPosts" maxrows="30">
	SELECT  	objectid, publishDate, teaser, title
	FROM 		#application.dbowner#farBlogPost
	WHERE		status=<cfqueryparam cfsqltype="cf_sql_varchar" value="approved" /> and farBlogID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#stObj.objectid#" />
	ORDER BY 	publishDate DESC
</cfquery>

<cfset qFeed = queryNew("title, content, publisheddate, rsslink") />
<cfloop query="qposts">
	<cfset queryaddrow(qFeed, 1) />
	<cfset querysetcell(qFeed, "title", qPosts.title) />
	<cfset querysetcell(qFeed, "content", application.fc.lib.blog.abbreviate(qPosts.teaser, 300)) />
	<cfset querysetcell(qFeed, "publisheddate", qPosts.publishDate) />
	<cfset querysetcell(qFeed, "rsslink", application.fapi.getLink(objectid=qPosts.objectid,includedomain=true)) />
</cfloop>

<!--- Set the feed metadata. --->
<cfset stprop = StructNew() />
<cfset stprop.title = xmlFormat(stObj.title) />
<cfset stprop.link = application.fapi.getLink(objectid=stObj.objectid,includedomain=true) />
<cfset stprop.description = xmlFormat(stObj.teaser) />
<cfset stprop.version = "rss_2.0" />

<!--- Create the feed. --->
<cffeed 
	action="create"
	query="#qFeed#"
	properties="#stProp#"
	xmlvar="rssXML" />

<cfcontent type="text/xml" reset="yes" variable="#tobinary(tobase64(rssXML))#" />


<!---<cfdump var="#XMLParse(rssXML)#">--->

<cfsetting enablecfoutputonly="false" />
