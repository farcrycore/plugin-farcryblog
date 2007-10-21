<cfsetting enablecfoutputonly="true" />

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />

<!--- set up page header --->
<admin:header title="Blog Posts" />

<ft:objectAdmin 
	title="Blog Posts" 
	typename="farBlogPost" 
	columnList="title,catblogpost,publishdate,bComment"
	sortableColumns="title,catblogpost,publishdate"
	lFilterFields="title"
	sqlorderby="publishdate desc"
	module="farcryblog/listblogpost.cfm" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />