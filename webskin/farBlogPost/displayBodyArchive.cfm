<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Body - Blog Post Archive --->
<!--- @@Description:  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />



<cfset qArchivePosts = getArchivePosts(archiveMonth="#url.archiveMonth#", archiveYear="#url.archiveYear#") />


<cfoutput>
<h1>Blog Archive - #monthAsString(url.archiveMonth)# #url.archiveYear#</h1>
<ul>
</cfoutput>

<cfloop query="qArchivePosts">
	<skin:view typename="farBlogPost" objectid="#qArchivePosts.objectid#" webskin="displayTeaserArchive" />
</cfloop>

<cfoutput>
</ul>
</cfoutput>

