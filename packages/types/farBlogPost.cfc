<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Post --->
<!--- @@Description: Blog post type component for the FarCry Blog plugin --->
<cfcomponent displayname="Blog Post" extends="farcry.core.packages.types.versions" bSchedule="true" bFriendly="true" bObjectBroker="true" lObjectBrokerWebskins=""
	hint="Manage your blog posts, create new missives, edit the HTML of individual posts, categorise posts by topic and schedule posts for future dates.">

<!--- properties --->
<cfproperty ftSeq="1" ftWizardStep="Start" ftFieldset="General Details" name="Title" type="string" required="true" default="" hint="Blog post title." ftLabel="Title" ftValidation="required" />
<cfproperty ftSeq="3" ftWizardStep="Start" ftFieldset="General Details" name="publishDate" type="date" required="false" default="" hint="The date that a blog post is sent live and appears on the public website" ftLabel="Publish Date" ftType="datetime" ftDefaultType="evaluate" ftDefault="now()" ftDateFormatMask="dd mmm yyyy" ftTimeFormatMask="hh:mm tt" ftToggleOffDateTime="false" />
<cfproperty ftSeq="5" ftWizardStep="Start" ftFieldset="General Details" name="displayMethod" type="string" required="true" default="displayPageStandard" hint="Display method to render." ftLabel="Content Template" ftType="webskin" ftPrefix="displayPageStandard" ftDefault="displayPageStandard" />
<cfproperty ftSeq="7" ftWizardStep="Start" ftFieldset="General Details" name="bComment" type="boolean" required="true" default="1" hint="Flag for enabling comments." ftLabel="Enable Comments?" />

<cfproperty ftSeq="10" ftWizardStep="Start" ftFieldset="Categorisation" name="catBlogPost" type="longchar" hint="Blog categorisation." ftLabel="Blog Category" ftType="category" ftAlias="farBlogPost" />

<cfproperty ftSeq="21" ftWizardStep="Blog Post" ftFieldset="Blog Details" name="Body" type="longchar" required="false" default="" hint="Main body of content." ftLabel="Blog Post" ftType="richtext" ftTemplateTypeList="dmImage,dmFile,dmFlash,dmNavigation,dmHTML" />
<cfproperty ftSeq="23" ftWizardStep="Blog Post" ftFieldset="Blog Details" name="Teaser" type="longchar" required="false" default="" hint="Teaser text." ftLabel="Teaser" />

<cfproperty ftSeq="25" ftWizardStep="Blog Post" ftFieldset="Related Content" name="aMedia" type="array" required="false" default="" hint="Mixed media content for this content." ftLabel="Media Library" ftJoin="dmImage,dmFile,dmFlash" />
<cfproperty ftSeq="26" ftWizardStep="Blog Post" ftFieldset="Related Content" name="bShowMediaInline" type="boolean" required="true" default="0" hint="Flag for showing media incline." ftLabel="Show Media Inline?" />
<cfproperty ftSeq="27" ftWizardStep="Blog Post" ftFieldset="Related Content" name="aRelatedPosts" type="array" required="false" default="" hint="Related blog posts." ftLabel="Related Blog Posts" ftJoin="farBlogPost" />


<!--- hidden attribute --->
<cfproperty name="lMedia" type="string" required="false" default="" hint="Mixed media content for this content." ftType="arrayList" ftArrayField="aMedia" />

<!--- system attribute --->
<cfproperty name="status" type="string" required="true" default="draft" hint="Status of the node (draft, pending, approved)." />

<!--- methods --->

<cffunction name="getComments" access="public" output="false" returntype="query" hint="Returns a query of objectids of all the comments attached to the blogpostid passed in.">
	<cfargument name="objectid" required="true" type="uuID" />
	
	<cfset var qComments = queryNew("total") />

	<cfquery datasource="#application.dsn#" name="qComments">
	SELECT objectid
	FROM farBlogComment
	WHERE parentid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#">
	ORDER BY datetimecreated
	</cfquery>

	<cfreturn qComments>
</cffunction>

<cffunction name="getTotalComments" access="public" output="false" returntype="numeric" hint="Returns the total of all the comments attached to the blogpostid passed in.">
	<cfargument name="objectid" required="true" type="uuID" />
	
	<cfset var qComments = getComments(arguments.objectid) />

	<cfreturn qComments.recordCount>
</cffunction>

<cffunction name="getRecentPosts" access="public" output="false" returntype="query" hint="Return a query of recent x blog posts.">
	<cfargument name="maxrows" default="5" type="numeric" />	
	<cfargument name="lCategoryIDs" default="" type="string" />

	<cfset var q = getPostsByCategoryList(lCategoryIDs="#arguments.lCategoryIDs#", maxRows="#arguments.maxRows#") />

	<cfreturn q />
</cffunction>



<cffunction name="getArchiveLinks" access="public" output="false" returntype="query" hint="Return a query of months that contain blog posts.">

	<cfquery datasource="#application.dsn#" name="qMonths">
	SELECT month(publishDate) as archiveMonth, year(publishDate) as archiveYear
	FROM farBlogPost
	GROUP BY month(publishDate), Year(publishDate), status
	HAVING farBlogPost.status = <cfqueryparam value="approved" cfsqltype="cf_sql_varchar" />
	ORDER BY archiveYear DESC, archiveMonth DESC
	</cfquery>

	<cfreturn qMonths />
</cffunction>

<cffunction name="getArchivePosts" access="public" output="false" returntype="query" hint="Return a query of posts for a specified month.">
	<cfargument name="archiveMonth" default="#month(now())#" type="numeric" />	
	<cfargument name="archiveYear" default="#year(now())#" type="numeric" />	
		
	<cfquery datasource="#application.dsn#" name="qArchivePosts">
	SELECT objectid
	FROM farBlogPost
	WHERE month(publishDate) = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.archiveMonth#">
	AND Year(publishDate) = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.archiveYear#">
	AND status = <cfqueryparam value="approved" cfsqltype="cf_sql_varchar" />
	</cfquery>

	<cfreturn qArchivePosts />
</cffunction>



<cffunction name="getPostsByCategory" access="public" output="false" returntype="query" hint="Return a query of posts in a category.">
	<cfargument name="categoryID" required="true" type="string" />
	<cfargument name="maxrows" default="5" type="numeric" />	

	<cfset var q = getPostsByCategoryList(lCategoryIDs="#arguments.categoryID#",maxrows="#arguments.maxrows#") />

	<cfreturn q />
</cffunction>

<cffunction name="getPostsByCategoryList" access="public" output="false" returntype="query" hint="Return a query of posts in a list of categories.">
	<cfargument name="lCategoryIDs" required="true" type="string" />
	<cfargument name="maxrows" default="5" type="numeric" />	

	<cfset var q = queryNew("objectID") />

	<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
	SELECT distinct objectID,title,publishDate
	FROM farBlogPost p
	WHERE status = <cfqueryparam value="approved" cfsqltype="cf_sql_varchar" />
	<cfif len(arguments.lCategoryIDs)>
		AND objectid in (
			select distinct objectid 
		    from refCategories 
		    where categoryID IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lCategoryIDs#" list="true" />)
		)
	</cfif>
	ORDER BY publishDate DESC
	</cfquery>

	<cfreturn q />
</cffunction>



<cffunction name="getPostCategories" access="public" output="false" returntype="query" hint="Return a query of categories assigned to a blog post.">
	<cfargument name="objectid" required="true" type="string" />

	<cfset var q = queryNew("objectID") />

	<cfquery datasource="#application.dsn#" name="q">
	select distinct categoryID 
    from refCategories 
    where objectid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#" />
	</cfquery>

	<cfreturn q />
</cffunction>

<cffunction name="getActiveCategories" access="public" output="false" returntype="query" hint="Return a query of categories assigned to a blog post.">
	<cfset var q = queryNew("objectID") />

	<cfquery datasource="#application.dsn#" name="q">
	SELECT c.objectid, c.categoryLabel, COUNT(c.objectid) AS assigned
	FROM dmCategory c 
		INNER JOIN refCategories p 
			INNER JOIN farBlogPost bp
			ON p.objectid = bp.objectid
		ON c.objectid = p.categoryID
	GROUP BY c.objectid, c.categoryLabel,bp.status
	HAVING bp.status = 'approved'
	</cfquery>

	<cfreturn q />
</cffunction>


</cfcomponent>