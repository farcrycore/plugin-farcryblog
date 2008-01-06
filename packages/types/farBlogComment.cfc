<cfcomponent extends="farcry.core.packages.types.types" name="blogcomment" displayname="Blog Comment" hint="blog comment"
	bObjectBroker="true" 
	lObjectBrokerWebskins="displayCommentBubble:15,editAddComment:0">

<cfproperty ftseq="1" ftfieldset="Blog Comment" name="subject" type="string" hint="Subject of comment." required="no" default="" blabel="true" ftlabel="Subject" ftvalidation="required" />
<cfproperty ftseq="2" ftfieldset="Blog Comment" name="description" type="longchar" hint="Comment description." required="no" default="" ftlabel="Description" />
<cfproperty ftseq="3" ftfieldset="Blog Comment" name="commenthandle" type="string" hint="Name or handle of poster." required="no" default="" ftlabel="Name" />
<cfproperty ftseq="4" ftfieldset="Blog Comment" name="email" type="string" hint="Email address of poster." required="no" default="" ftlabel="Email" ftvalidation="validate-email" />
<cfproperty ftseq="5" ftfieldset="Blog Comment" name="website" type="string" hint="Website address of poster." required="no" default="" fttype="url" ftlabel="Website" />
<cfproperty ftseq="6" ftfieldset="Blog Comment" name="parentid" type="uuid" hint="Parent content object reference." required="no" ftjoin="farblogpost" ftlabel="Parent Blog Post" />

<cfproperty ftseq="10" ftfieldset="Blog Comment" name="bCaptcha" type="boolean" hint="Flag for lylacaptcha." default="0" required="no" fttype="lylacaptcha" ftlabel="Captcha" />
<cfproperty ftseq="20" ftfieldset="Blog Comment" name="bSubscribe" type="boolean" hint="Flag for thread subscription." default="0" required="no" fttype="boolean" ftlabel="Subscribe to thread?" />

<!--- getway methods --->
<cffunction name="getcomments" returntype="query" output="false" access="public" hint="Returns all comments that match a specific content reference.">
	<cfargument name="parentid" required="true" type="uuid" hint="Object reference for the parent content item." />
	<cfset var qComments=querynew("blah") />
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


<!--- save events --->
<cffunction name="AfterSave" access="public" output="false" returntype="struct" hint="Called from setData and createData and run after the object has been saved.">
	<cfargument name="stProperties" required="yes" type="struct" hint="A structure containing the contents of the properties that were saved to the object.">

	<cfset arguments.stProperties = super.afterSave(stProperties=arguments.stProperties) />
	
	<!--- Flush the blog post this comment is refering too. --->
	<cfset createObject("component", "farcry.core.packages.fourq.objectBroker").RemoveFromObjectBroker(lObjectIDs=arguments.stProperties.parentid, typename="farBlogPost") />		
	
	<!--- send email alerts --->
	<cfset sendAuthorAlert(objectid=arguments.stProperties.objectid) />
	<cfset sendSubscriptionAlert(objectid=arguments.stProperties.objectid) />

	<cfreturn stProperties />
</cffunction> 

<cffunction name="BeforeSave" access="public" output="false" returntype="struct">
	<cfargument name="stProperties" required="true" type="struct">
	<cfargument name="stFields" required="true" type="struct">
	<cfargument name="stFormPost" required="false" type="struct">
		
	<cfset arguments.stproperties=super.beforeSave(stproperties=arguments.stproperties, stfields=arguments.stfields, stformpost=arguments.stformpost) />
	
	<cfreturn arguments.stProperties />
</cffunction>

<cffunction name="unsubscribeUser" access="public" output="false" returntype="void">
	<cfargument name="objectid" required="true" type="uuid" hint="UUID for the blog post of comment." />
	<cfset var stobj=getData(objectid=arguments.objectid) />
	
	<cfquery datasource="#application.dsn#" name="qSubscribers">
	UPDATE farBlogComment
	SET bSubscribe = 0
	WHERE parentid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stobj.parentid#" />
	AND email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stobj.email#" />
	</cfquery>
		
</cffunction>

<!--- send alerts --->
<cffunction name="sendAuthorAlert" access="private" output="false" returntype="void">
	<cfargument name="objectid" required="true" type="uuid" />
	<cfset var stobj=getData(objectid=arguments.objectid) />
	<cfset var oPost=createObject("component", application.stcoapi["farblogpost"].typepath) />
	<cfset var stPost=oPost.getData(objectid=stobj.parentid) />
	
	<cfmail to="modius@daemon.com.au" from="modius@gmail.com" subject="#application.config.general.sitetitle#: #left(stpost.title,"50")#" type="text">
<cfoutput>
There's been an update to the post you made at *#application.config.general.sitetitle#*

#stpost.title#
-------------------------------------------------
#stpost.teaser#

New Comment
-------------------------------------------------
#stobj.subject#
#stobj.description#
#stobj.commenthandle#


Link back to the thread:
http://#cgi.SERVER_NAME#/index.cfm?objectid=#stobj.parentid#
</cfoutput>			
	</cfmail>
		
</cffunction>

<cffunction name="sendSubscriptionAlert" access="private" output="false" returntype="void">
	<cfargument name="objectid" required="true" type="uuid" />
	<cfset var stobj=getData(objectid=arguments.objectid) />
	<cfset var oPost=createObject("component", application.stcoapi["farblogpost"].typepath) />
	<cfset var stPost=oPost.getData(objectid=stobj.parentid) />
	<cfset var qSubscribers=queryNew("objectid") />

	<cfquery datasource="#application.dsn#" name="qSubscribers">
	SELECT DISTINCT objectid
	FROM farBlogComment
	WHERE parentid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stobj.parentid#" />
	AND bSubscribe = 1
	</cfquery>
	
	<cfloop query="qSubscribers">
		<cfmail to="modius@daemon.com.au" from="modius@gmail.com" subject="#application.config.general.sitetitle#: #left(stpost.title,"50")#" type="text">
<cfoutput>
There's been an update to the thread you subscribed to at *#application.config.general.sitetitle#*

#stpost.title#
-------------------------------------------------
#stpost.teaser#

New Comment
-------------------------------------------------
#stobj.subject#
#stobj.description#
#stobj.commenthandle#


Link back to the thread:
http://#cgi.SERVER_NAME#/index.cfm?objectid=#stobj.parentid#

If you would like to unsubscribe from this thread follow the link below:
http://#cgi.SERVER_NAME#/index.cfm?objectid=#stobj.objectid#
</cfoutput>			
		</cfmail>
	</cfloop>
		
</cffunction>



</cfcomponent>