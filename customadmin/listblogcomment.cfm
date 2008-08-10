<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Manage blog comments --->
<!--- @@Description: Blog comment content type administration for the FarCry Blog plugin --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

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
	columnList="parentID,dateTimeCreated"
	acustomcolumns="#aCustomColumns#"
	sortableColumns="parentID,dateTimeCreated"
	lFilterFields="commentHandle,email,website"
	sqlOrderBy="dateTimeCreated DESC"
	plugin="farcryblog"
	module="listblogcomment.cfm" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />