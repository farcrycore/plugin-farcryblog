<cfsetting enablecfoutputonly="true" />

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />

<!--- set up page header --->
<admin:header title="Blog Comments" />

<ft:objectAdmin 
	title="Blog Comments" 
	typename="farBlogComment" 
	columnList="subject,commenthandle,email,website,parentid,datetimecreated"
	sortableColumns="subject,commenthandle,email,website,parentid,datetimecreated"
	lFilterFields="subject,commenthandle,email,website"
	sqlorderby="datetimecreated desc" 
	module="farcryblog/listblogcomment.cfm" />

<!--- page footer --->
<admin:footer />

<cfsetting enablecfoutputonly="false" />