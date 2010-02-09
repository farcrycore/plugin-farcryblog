<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Category List (admin) --->
<!--- @@Description:  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfloop array="#stObj.aCategories#" index="i">
	<skin:view objectID="#i#" webskin="displayCategory" typename="farBlogCategory" />
</cfloop>

<cfsetting enablecfoutputonly="false" />