<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Manage blog comments --->
<!--- @@Description: Blog comment content type administration for the FarCry Blog plugin --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

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

<ft:objectAdmin
	title="Blog Comments"
	typename="farBlogComment"
	columnList="bPublish,parentID,dateTimeCreated"
	acustomcolumns="#aCustomColumns#"
	sortableColumns="parentID,bPublish,dateTimeCreated"
	lFilterFields="commentHandle,email,website"
	sqlOrderBy="dateTimeCreated DESC"
	lCustomActions="Hide Comment,Publish Comment"
	plugin="farcryblog"
	module="listblogcomment.cfm" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />