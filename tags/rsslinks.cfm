<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Blog RSS Links --->

<cfif thistag.ExecutionMode eq "start">
	<cfparam name="attributes.bIncludeAllFeed" default="true" />
	<cfparam name="attributes.lBlogSpecificFeeds" default="*" />
	
	<cfset qBlogs = application.fapi.getContentType(typename="farBlog").getBlogs() />
	
	<cfif attributes.bIncludeAllFeed>
		<cfoutput><link href="#application.fapi.getLink(type='farBlog',view='displayTypeRSS',urlparameters='ajaxmode=1')#" type="application/rss+xml" rel="alternate" title="All #application.config.general.sitetitle# Blog Posts" /></cfoutput>
	</cfif>
	<cfloop query="qBlogs">
		<cfif attributes.lBlogSpecificFeeds eq "*" or listcontains(attributes.lBlogSpecificFeeds,qBlogs.objectid)>
			<cfoutput><link href="#application.fapi.getLink(objectid=qBlogs.objectid,view='displayRSS',urlparameters='ajaxmode=1')#" type="application/rss+xml" rel="alternate" title="#qBlogs.title# Blog Posts" /></cfoutput>
		</cfif>
	</cfloop>
</cfif>

<cfsetting enablecfoutputonly="false" />