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

<cfproperty ftSeq="10" ftFieldset="Related Content" ftWizardStep="Blog Post" name="aMedia" type="array" required="false" default="" hint="Mixed media content for this content." ftLabel="Media Library" ftJoin="dmImage,dmFile,dmFlash" />
<cfproperty name="lMedia" type="string" required="false" default="" hint="Mixed media content for this content." ftType="arrayList" ftArrayField="aMedia" />
<cfproperty ftSeq="11" ftFieldset="Related Content" ftWizardStep="Blog Post" name="aRelatedPosts" type="array" required="false" default="" hint="Related blog posts." ftLabel="Related Blog Posts" ftJoin="farBlogPost" />

<cfproperty ftSeq="21" ftFieldset="Story Details" ftWizardStep="Blog Post" name="Body" type="longchar" required="false" default="" hint="Main body of content." ftLabel="Body Content" ftType="richtext" ftTemplateTypeList="dmImage,dmFile,dmFlash,dmNavigation,dmHTML" />
<cfproperty ftSeq="22" ftFieldset="Story Details" ftWizardStep="Blog Post" name="teaserImage" type="UUID" required="false" default="" hint="Teaser image to display." ftLabel="Teaser Image" ftType="UUID" ftJoin="dmImage" />
<cfproperty ftSeq="23" ftFieldset="Story Details" ftWizardStep="Blog Post" name="Teaser" type="longchar" required="false" default="" hint="Teaser text." ftLabel="Teaser" />

<cfproperty ftSeq="30" ftFieldset="Categorisation" ftWizardStep="Categorisation" name="aCategories" type="array" required="false" default="" hint="Blog categorisation." ftLabel="Blog Category" ftType="array" ftJoin="farBlogCategory" />

<!--- system attribute --->
<cfproperty name="status" type="string" required="true" default="draft" hint="Status of the node (draft, pending, approved)." />

<!--- methods --->
<cffunction name="getRecentPosts" access="public" output="false" returntype="query" hint="Return a query of recent x blog posts.">
	<cfargument name="maxrows" default="5" type="numeric" />

	<cfset var q = querynew("objectID, title, publishDate") />

	<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
	SELECT objectID, title, publishDate
	FROM farBlogPost
	WHERE status = 'approved'
	ORDER BY publishDate DESC
	</cfquery>

	<cfreturn q />
</cffunction>

</cfcomponent>