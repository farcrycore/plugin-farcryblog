<cfsetting enablecfoutputonly="true" />

<!--- tag library --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfquery datasource="#application.dsn#" name="qComments">
SELECT count(*) AS total
FROM farBlogComment
WHERE parentid = '#stobj.objectid#'
</cfquery>

<cfoutput>
<p>Geoff Bowers : comments (#qComments.total#): </cfoutput><skin:buildlink objectid="#stobj.objectid#" linktext="permalink" /><cfoutput></p>
</cfoutput>


<cfsetting enablecfoutputonly="false" />