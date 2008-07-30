<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Blog: Post --->
<!--- @@Description: Blog post type component for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<cfcomponent displayname="Blog Post" extends="farcry.core.packages.types.versions" bSchedule="true" bFriendly="true" bObjectBroker="true" lObjectBrokerWebskins="display*"
	hint="Blog posts">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="General Details" ftWizardStep="Start" name="Title" type="string" required="true" default="" hint="Blog post title." ftLabel="Title" ftValidation="required" />
<cfproperty ftSeq="3" ftFieldset="General Details" ftWizardStep="Start" name="publishDate" type="date" required="false" default="" hint="The date that a blog post is sent live and appears on the public website" ftLabel="Publish Date" ftType="datetime" ftDefaultType="evaluate" ftDefault="now()" ftDateFormatMask="dd mmm yyyy" ftTimeFormatMask="hh:mm tt" ftToggleOffDateTime="false" />
<cfproperty ftSeq="5" ftFieldset="General Details" ftWizardStep="Start" name="displayMethod" type="string" required="true" default="displayPageStandard" hint="Display method to render." ftLabel="Content Template" ftType="webskin" ftPrefix="displayPageStandard" ftDefault="displayPageStandard" />
<cfproperty ftSeq="7" ftFieldset="General Details" ftWizardStep="Start" name="bComment" type="boolean" required="true" default="1" hint="Flag for enabling comments." ftLabel="Enable Comments?" />

<cfproperty ftSeq="10" ftFieldset="Media" ftWizardStep="Blog Post" name="aMedia" type="array" required="false" default="" hint="Mixed media content for this content." ftLabel="Media Library" ftJoin="dmImage,dmFile,dmFlash" />
<cfproperty name="lMedia" type="string" required="false" default="" hint="Mixed media content for this content." ftType="arrayList" ftArrayField="aMedia" />
<cfproperty ftSeq="15" ftFieldset="Media" ftWizardStep="Blog Post" name="bShowMediaInline" type="boolean" required="true" default="0" hint="Flag for showing media incline." ftLabel="Show Media Inline?" />

<cfproperty ftSeq="15" ftFieldset="Related Content" ftWizardStep="Blog Post" name="aRelatedPosts" type="array" required="false" default="" hint="Related blog posts." ftLabel="Related Blog Posts" ftJoin="farBlogPost" />

<cfproperty ftSeq="21" ftFieldset="Story Details" ftWizardStep="Blog Post" name="Body" type="longchar" required="false" default="" hint="Main body of content." ftLabel="Body Content" ftType="richtext" ftTemplateTypeList="dmImage,dmFile,dmFlash,dmNavigation,dmHTML" />
<cfproperty ftSeq="22" ftFieldset="Story Details" ftWizardStep="Blog Post" name="teaserImage" type="UUID" required="false" default="" hint="Teaser image to display." ftLabel="Teaser Image" ftType="UUID" ftJoin="dmImage" />
<cfproperty ftSeq="23" ftFieldset="Story Details" ftWizardStep="Blog Post" name="Teaser" type="longchar" required="false" default="" hint="Teaser text." ftLabel="Teaser" />

<cfproperty ftSeq="30" ftFieldset="Categorisation" ftWizardStep="Categorisation" name="aCategories" type="array" required="false" default="" hint="Blog categorisation." ftLabel="Blog Category" ftType="array" ftJoin="farBlogCategory" />

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

	<cfset var q = createObject("component", application.stcoapi["farBlogCategory"].packagePath).getPostsByCategoryList(lObjectIDs="#arguments.lCategoryIDs#", maxRows="#arguments.maxRows#") />

	<cfreturn q />
</cffunction>



<cffunction name="getArchiveLinks" access="public" output="false" returntype="query" hint="Return a query of months that contain blog posts.">

	<cfquery datasource="#application.dsn#" name="qMonths">
	SELECT month(publishDate) as archiveMonth, year(publishDate) as archiveYear
	FROM farBlogPost
	GROUP BY month(publishDate), Year(publishDate)
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
	</cfquery>

	<cfreturn qArchivePosts />
</cffunction>

</cfcomponent>