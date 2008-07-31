<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Category type --->
<!--- @@Description: Blog category type component for the FarCry Blog plugin --->
<cfcomponent displayname="Blog Category" extends="farcry.core.packages.types.types" output="false" bSchedule="true" bFriendly="true" bObjectBroker="true" hint="Blog categories">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="General Details" name="Title" type="string" required="true" default="" hint="Category title." ftLabel="Title" ftValidation="required" />
<cfproperty ftSeq="2" ftFieldset="General Details" name="Description" type="longchar" required="false" default="" hint="Category description." ftLabel="Description" />

<!--- methods --->
<cffunction name="getActiveCategories" access="public" output="false" returntype="query" hint="Return a query of categories that have posts assigned.">
	<cfset var q = queryNew("objectID, label, assigned") />

	<cfquery datasource="#application.dsn#" name="q">
	SELECT
		c.objectID,
		c.title,
		COUNT(c.objectID) AS assigned
	FROM farBlogCategory c
	INNER JOIN farBlogPost_aCategories p
	ON c.objectID = p.data
	GROUP BY c.objectID, c.title
	</cfquery>

	<cfreturn q />
</cffunction>

<cffunction name="getPostsByCategory" access="public" output="false" returntype="query" hint="Return a query of posts in a category.">
	<cfargument name="objectID" required="true" type="string" />
	<cfargument name="maxrows" default="5" type="numeric" />	

	<cfset var q = getPostsByCategoryList(lObjectIDs="#arguments.objectid#",maxrows="#arguments.maxrows#") />

	<cfreturn q />
</cffunction>

<cffunction name="getPostsByCategoryList" access="public" output="false" returntype="query" hint="Return a query of posts in a list of categories.">
	<cfargument name="lObjectIDs" required="true" type="string" />
	<cfargument name="maxrows" default="5" type="numeric" />	

	<cfset var q = queryNew("objectID") />

	<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
	SELECT distinct p.objectID, p.title, p.publishDate
	FROM farBlogPost p
	INNER JOIN farBlogPost_aCategories c
	ON p.objectID = c.parentID
	<cfif listLen(arguments.lObjectIDs)>
		AND c.data IN (<cfqueryparam value="#arguments.lObjectIDs#" cfsqltype="cf_sql_varchar" list="true">)
	</cfif>
	WHERE p.status = <cfqueryparam value="approved" cfsqltype="cf_sql_varchar" />
	ORDER BY p.publishDate DESC
	</cfquery>

	<cfreturn q />
</cffunction>

</cfcomponent>