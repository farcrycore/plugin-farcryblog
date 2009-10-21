<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Category Archive --->
<!--- @@Description: Standard full page display for blog categories. --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/plugins/farcryblog/tags/" prefix="blog" />

<cfoutput>
<h2>#stobj.categoryLabel#</h2>
<!--- <p>#stobj.description#</p> --->
</cfoutput>

<cfset qCategoryBlogPosts = createObject("component", application.stcoapi["farBlogPost"].packagePath).getPostsByCategory(categoryid=stobj.objectid, maxrows=100) />


<skin:pagination qrecordset="#qCategoryBlogPosts#" recordsPerPage="10">
	<skin:view typename="farBlogPost" objectid="#stobject.objectid#" webskin="displayTeaserArchive" />
</skin:pagination>

<cfsetting enablecfoutputonly="false" />