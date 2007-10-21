<cfsetting enablecfoutputonly="true" />

<!--- tag library --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!--- run tag once --->
<cfif thistag.ExecutionMode eq "end">
	<cfexit method="exittag" />
</cfif>

<!--- required attributes --->
<cfparam name="attributes.postid" type="uuid" />

<!--- comment list --->		
<skin:view typename="farBlogPost" objectid="#attributes.postid#" webskin="displayComments" />

<!--- comments form --->
<cfset stProps = structNew() />
<cfset stProps.parentid = attributes.postid /> 		
<skin:view typename="farBlogComment" webskin="editAddComment" stProps="#stProps#" />

<cfsetting enablecfoutputonly="false" />