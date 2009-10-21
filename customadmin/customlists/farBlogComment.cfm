<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Manage blog comments --->
<!--- @@Description: Blog comment content type administration for the FarCry Blog plugin --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- Admin page parameters --->
<cfparam name="url.farBlogID" default="" />
<cfparam name="url.farBlogPostID" default="" /><!--- One of these is required --->
<cfparam name="url.status" default="all" /><!--- Which posts to show --->

<cfif len(url.farBlogPostID)>
	<cfset stBlogPost = application.fapi.getContentObject(objectid=url.farBlogPostID,typename="farBlogPost") />
	<cfset stBlog = application.fapi.getContentObject(objectid=stBlogPost.farBlogID,typename="farBlog") />
	<cfswitch expression="#url.status#">
		<cfcase value="all">
			<cfset sqlWhere = "parentID='#url.farBlogPostID#'" />
			<cfset adminTitle = "All #stBlogPost.title# (#stBlog.title#) Blog Comments" />
		</cfcase>
		<cfcase value="pending">
			<cfset sqlWhere = "parentID='#url.farBlogPostID#' and bPublish=0" />
			<cfset adminTitle = "Pending #stBlogPost.title# (#stBlog.title#) Blog Comments" />
		</cfcase>
		<cfcase value="approved">
			<cfset sqlWhere = "parentID='#url.farBlogPostID#' and bPublish=1" />
			<cfset adminTitle = "Approved #stBlogPost.title# (#stBlog.title#) Blog Comments" />
		</cfcase>
	</cfswitch>
<cfelseif len(url.farBlogID)>
	<cfset stBlog = application.fapi.getContentObject(objectid=url.farBlogID,typename="farBlog") />
	<cfswitch expression="#url.status#">
		<cfcase value="all">
			<cfset sqlWhere = "parentID in (select objectid from #application.dbowner#farBlogPost where farBlogID='#url.farBlogID#')" />
			<cfset adminTitle = "All #stBlog.title# Blog Comments" />
		</cfcase>
		<cfcase value="pending">
			<cfset sqlWhere = "parentID in (select objectid from #application.dbowner#farBlogPost where farBlogID='#url.farBlogID#')" />
			<cfset adminTitle = "Pending #stBlog.title# Blog Comments" />
		</cfcase>
		<cfcase value="approved">
			<cfset sqlWhere = "parentID in (select objectid from #application.dbowner#farBlogPost where farBlogID='#url.farBlogID#')" />
			<cfset adminTitle = "Approved #stBlog.title# Blog Comments" />
		</cfcase>
	</cfswitch>
<cfelse>
	<cfthrow message="farBlogPostID or farBlogID MUST be passed in through the URL" />
</cfif>

<!--- custom option: Publish Comment ---->
<ft:processform action="Publish Comment">
	<cfset oComment = createObject("component",application.stCoapi["farBlogComment"].packagePath) />
	<cfset stComment = oComment.getData(objectID=form.selectedObjectID) />
	<cfset stComment.bPublish = 1 />
	<cfset oComment.setData(stProperties=stComment) />
</ft:processform>

<ft:processform action="Hide Comment">
	<cfset oComment = createObject("component",application.stCoapi["farBlogComment"].packagePath) />
	<cfset stComment = oComment.getData(objectID=form.selectedObjectID) />
	<cfset stComment.bPublish = 0 />
	<cfset oComment.setData(stProperties=stComment) />
</ft:processform>

<!--- set up custom cell renderers --->
<cfscript>
	aCustomColumns = arrayNew(1);
	aCustomColumns[1] = structNew();
	aCustomColumns[1].webskin = "cellCommentHandle.cfm"; // located in the webskin of the type the controller is listing on
	aCustomColumns[1].title = "Comment"; 
	aCustomColumns[1].sortable = true; //optional
	aCustomColumns[1].property = "commentHandle"; //mandatory is sortable=true
</cfscript>

<!--- set up page header --->
<admin:header title="Blog Comments" />

<cfif len(url.farBlogID)>
	<cfoutput><p><a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlog.cfm&plugin=farcryblog">Return to Blogs</a></p></cfoutput>
<cfelse>
	<cfoutput><p><a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogPost.cfm&plugin=farcryblog&blog=#stBlog.objectid#&status=all">Return to #stBlog.title# Posts</a></p></cfoutput>
</cfif>

<ft:objectAdmin
	title="#adminTitle#"
	typename="farBlogComment"
	columnList="bPublish,parentID,dateTimeCreated"
	acustomcolumns="#aCustomColumns#"
	sortableColumns="parentID,bPublish,dateTimeCreated"
	lFilterFields="commentHandle,email,website"
	sqlOrderBy="dateTimeCreated DESC"
	sqlWhere="#sqlWhere#"
	lCustomActions="Hide Comment,Publish Comment"
	plugin="farcryblog" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />