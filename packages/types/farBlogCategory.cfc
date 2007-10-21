<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: FarCry Blog Category Component --->
<!--- @@Description: farBlogCategory Type --->
<!--- @@Developer: Geoff Bowers (modius@daemon.com.au) --->
<cfcomponent extends="farcry.core.packages.types.types" displayname="Blog Category" hint="Blog category." bSchedule="true" bFriendly="true" bObjectBroker="true">
<!------------------------------------------------------------------------
type properties
------------------------------------------------------------------------->	
<cfproperty ftseq="1" ftfieldset="General Details" name="Title" type="string" hint="Category title." required="no" default="" ftlabel="Title" ftvalidation="required" />
<cfproperty ftseq="2" ftfieldset="General Details" name="Description" type="longchar" hint="Category description." required="no" default="" ftlabel="Description" />



<!------------------------------------------------------------------------
gateway methods 
------------------------------------------------------------------------->	
<cffunction name="getActiveCategories" access="public" output="false" hint="Return a query of categories that have posts assigned." returntype="query">
	
	<cfset var q=queryNew("objectid, label, assigned") />
	
	<cfquery datasource="#application.dsn#" name="q">
	SELECT 
		c.objectid, 
		c.title, 
		count(c.objectid) AS assigned
	FROM farBlogCategory c INNER JOIN farBlogPost_aCategories p ON c.objectid = p.data
	GROUP BY c.objectid, c.title
	</cfquery>
	
	<cfreturn q />
</cffunction>

<cffunction name="getPostsByCategory" access="public" output="false" hint="Return a query of categories that have posts assigned." returntype="query">
	<cfargument name="objectid" required="true" type="UUID" />
	<cfset var q=queryNew("objectid") />
	
	<cfquery datasource="#application.dsn#" name="q">
	SELECT p.objectid
	FROM farBlogPost p, farBlogPost_aCategories c
	WHERE p.objectid = c.parentid 
	AND c.data = '#arguments.objectid#'
	AND p.status = 'approved'
	ORDER BY p.publishdate DESC
	</cfquery>
	
	<cfreturn q />
</cffunction>

</cfcomponent>



