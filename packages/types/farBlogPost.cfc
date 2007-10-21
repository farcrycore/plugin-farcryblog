<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: FarCry Blog Post Component --->
<!--- @@Description: farBlogPost Type --->
<!--- @@Developer: Geoff Bowers (modius@daemon.com.au) --->
<cfcomponent extends="farcry.core.packages.types.versions" displayname="Blog Post" hint="Blog post." bSchedule="true" bFriendly="true"
	bObjectBroker="true" 
	<!--- lObjectBrokerWebskins="display*" --->>
<!------------------------------------------------------------------------
type properties
------------------------------------------------------------------------->	
<cfproperty ftseq="1" ftfieldset="General Details" ftwizardstep="Start" name="Title" type="string" hint="News title." required="no" default="" ftlabel="Title" ftvalidation="required" />
<cfproperty ftseq="3" ftfieldset="General Details" ftwizardstep="Start" name="publishDate" type="date" hint="The date that a news object is sent live and appears on the public website" required="no" default="" ftDefaultType="Evaluate" ftDefault="now()" ftType="datetime" ftDateFormatMask="dd mmm yyyy" ftTimeFormatMask="hh:mm tt" ftToggleOffDateTime="false" ftlabel="Publish Date" />
<cfproperty ftseq="5" ftfieldset="General Details" ftwizardstep="Start" name="displayMethod" type="string" hint="Display method to render." required="yes" default="display" fttype="webskin" ftprefix="displayPage" ftlabel="Content Template" />

<cfproperty ftseq="10" ftfieldset="Related Content" ftwizardstep="Blog Post" name="aMedia" type="array" hint="Mixed media content for this content." required="no" default="" ftJoin="dmImage,dmfile,dmflash" ftlabel="Media Library" />
<cfproperty name="lMedia" type="string" hint="Mixed media content for this content." required="no" default="" fttype="arrayList" ftArrayField="aMedia" />
<cfproperty ftseq="11" ftfieldset="Related Content" ftwizardstep="Blog Post" name="aRelatedPosts" type="array" hint="Related blog posts." required="no" default="" ftJoin="farBlogPost" ftlabel="Related Blog Posts" />

<cfproperty ftseq="21" ftfieldset="Story Details" ftwizardstep="Blog Post" name="Body" type="longchar" hint="Main body of content." required="no" default="" ftType="RichText" ftlabel="Body Content" ftTemplateTypeList="dmImage,dmfile,dmflash,dmNavigation,dmHTML" />
<cfproperty ftseq="22" ftfieldset="Story Details" ftwizardstep="Blog Post" name="teaserImage" type="UUID" hint="Teaser image to display." required="no" default="" fttype="uuid" ftjoin="dmimage" ftlabel="Teaser Image" />
<cfproperty ftseq="23" ftfieldset="Story Details" ftwizardstep="Blog Post" name="Teaser" type="longchar" hint="Teaser text." required="no" default="" ftlabel="Story teaser" />

<cfproperty ftseq="30" ftfieldset="Categorisation" ftwizardstep="Categorisation" name="aCategories" type="array" hint="Blog categorisation." required="no" default="" fttype="array" ftjoin="farblogcategory" ftlabel="Blog Category" />
<cfproperty ftseq="31" ftfieldset="Categorisation" ftwizardstep="Categorisation" name="catBlogPost" type="string" hint="Blog categorisation." required="no" default="" fttype="category" ftalias="farblogpost" ftlabel="Blog Category" />

<cfproperty ftseq="40" ftfieldset="Commenting" name="bComment" type="boolean" hint="Flag for enabling comments." default="1" required="no" ftlabel="Enable Comments?" />


<!--- system attribute --->
<cfproperty name="status" type="string" hint="Status of the node (draft, pending, approved)." required="yes" default="draft" />


<!------------------------------------------------------------------------
object methods 
------------------------------------------------------------------------->	
<cffunction name="getRecentPosts" access="public" output="false" hint="Return a query of recent x blog posts." returntype="query">
	<cfargument name="maxrows" default="5" type="numeric" />
	
	<cfset var q=queryNew("objectid,title,publishdate") />
	
	<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
	SELECT objectid, title, publishdate
	FROM farBlogPost
	WHERE status = 'approved'
	ORDER BY publishdate DESC
	</cfquery>
	
	<cfreturn q />
</cffunction>

</cfcomponent>



