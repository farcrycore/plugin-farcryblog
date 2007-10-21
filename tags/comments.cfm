<cfsetting enablecfoutputonly="true" />

<!--- tag library --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!--- run tag once --->
<cfif thistag.ExecutionMode eq "end">
	<cfexit method="exittag" />
</cfif>

<!--- required attributes --->
<cfparam name="attributes.postid" type="uuid" />

<!--- optional attributes --->
<cfparam name="attributes.bComment" default="false" type="boolean" />

<!--- comment list --->		
<skin:view typename="farBlogPost" objectid="#attributes.postid#" webskin="displayComments" />

<!--- comments form --->
<cfif attributes.bComment>
	<cfset stProps = structNew() />
	<cfset stProps.parentid = attributes.postid /> 		
	<skin:view typename="farBlogComment" webskin="editAddComment" stProps="#stProps#" />
</cfif>

<cfsetting enablecfoutputonly="false" />