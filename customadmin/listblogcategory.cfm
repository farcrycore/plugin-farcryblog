<cfsetting enablecfoutputonly="true">

<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/admin/" prefix="admin" />

<!--- set up page header --->
<admin:header title="Blog Category" />

<ft:objectAdmin
	title="Blog Category"
	typename="farblogcategory"
	ColumnList="Title,Description,datetimelastupdated"
	SortableColumns="Title,Description,datetimelastupdated"
	lFilterFields="Title"
	sqlorderby="Title" />

<admin:footer />

<cfsetting enablecfoutputonly="no">
