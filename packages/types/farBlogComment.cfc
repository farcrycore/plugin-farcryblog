<cfcomponent extends="farcry.core.packages.types.types" name="blogcomment" displayname="Blog Comment" hint="blog comment"
	bObjectBroker="true" 
	lObjectBrokerWebskins="displayCommentBubble:15,editAddComment:0">

<cfproperty ftseq="1" ftfieldset="Blog Comment" name="subject" type="string" hint="Subject of comment." required="no" default="" blabel="true" ftlabel="Subject" ftvalidation="required" />
<cfproperty ftseq="2" ftfieldset="Blog Comment" name="description" type="longchar" hint="Comment description." required="no" default="" ftlabel="Description" />
<cfproperty ftseq="3" ftfieldset="Blog Comment" name="commenthandle" type="string" hint="Name or handle of poster." required="no" default="" ftlabel="Name" />
<cfproperty ftseq="4" ftfieldset="Blog Comment" name="email" type="string" hint="Email address of poster." required="no" default="" ftlabel="Email" ftvalidation="validate-email" />
<cfproperty ftseq="5" ftfieldset="Blog Comment" name="website" type="string" hint="Website address of poster." required="no" default="" fttype="url" ftlabel="Website" />
<cfproperty ftseq="6" ftfieldset="Blog Comment" name="parentid" type="uuid" hint="Parent content object reference." required="no" ftjoin="farblogpost" ftlabel="Parent Blog Post" />

<cfproperty ftseq="7" ftfieldset="Blog Comment" name="bCaptcha" type="boolean" hint="Flag for lylacaptcha." default="0" required="no" fttype="lylacaptcha" ftlabel="Captcha" />




<cffunction name="getcomments" returntype="query" output="false" access="public" hint="Returns all comments that match a specific content reference.">
	<cfargument name="parentid" required="true" type="uuid" hint="Object reference for the parent content item.">
	<cfset var qComments=querynew("blah")>
	<cfquery datasource="#application.dsn#" name="qComments">
	SELECT objectid, subject, description, commenthandle, datetimecreated
	FROM farBlogComment
	WHERE parentid = '#arguments.parentid#'
	ORDER BY datetimecreated
	</cfquery>
	<cfreturn qComments />
</cffunction>

<cffunction name="getRecentComments" access="public" output="false" hint="Return a query of recent x blog comments." returntype="query">
	<cfargument name="maxrows" default="5" type="numeric" />
	
	<cfset var q=queryNew("objectid, subject, commenthandle, datetimecreated") />
	
	<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
	SELECT objectid, subject, commenthandle, datetimecreated
	FROM farBlogComment
	ORDER BY datetimecreated DESC
	</cfquery>
	
	<cfreturn q />
</cffunction>


<cffunction name="AfterSave" access="public" output="false" returntype="struct" hint="Called from setData and createData and run after the object has been saved.">
		<cfargument name="stProperties" required="yes" type="struct" hint="A structure containing the contents of the properties that were saved to the object.">

		<cfmail to="modius@daemon.com.au" from="modius@gmail.com" subject="farBlogComment.beforeSave() dump" type="html">
			<cfdump var="#form#" label="FORM Variables" />
			<cfdump var="#arguments#" label="Arguments" />
		</cfmail>

		<cfset arguments.stProperties = super.afterSave(stProperties=arguments.stProperties) />
		
		<!--- Flush the blog post this comment is refering too. --->
		<cfset createObject("component", "farcry.core.packages.fourq.objectBroker").RemoveFromObjectBroker(lObjectIDs=arguments.stProperties.parentid, typename="farBlogPost") />		

		<cfreturn stProperties />
</cffunction> 
	
<cffunction name="BeforeSave" access="public" output="false" returntype="struct">
	<cfargument name="stProperties" required="true" type="struct">
	<cfargument name="stFields" required="true" type="struct">
	<cfargument name="stFormPost" required="false" type="struct">
		
	<cfset arguments.stproperties=super.beforeSave(stproperties=arguments.stproperties, stfields=arguments.stfields, stformpost=arguments.stformpost) />
	
	<cfreturn arguments.stProperties />
</cffunction>


</cfcomponent>