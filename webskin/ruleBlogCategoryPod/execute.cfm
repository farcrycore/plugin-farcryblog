<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Execution of ruleBlogCategoryPod --->
<!--- @@Description: Lists all active blog categories. --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<cfset qCats=createObject("component", application.stcoapi["farBlogPost"].typepath).getActiveCategories() />

<cfif structKeyExists(stobj, "catorder") AND stobj.catorder eq "alpha">
	<cfquery dbtype="query" name="qCats">
	SELECT * FROM qCats
	ORDER BY categorylabel
	</cfquery>
</cfif>

<skin:view objectid="#stobj.objectid#" typename="ruleBlogCategoryPod" webskin="displayBody" qCats="#qCats#" />

<cfsetting enablecfoutputonly="false" />
