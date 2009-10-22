<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display post comments --->
<!--- @@Description: Comment list display for blog post --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport prefix="ft" taglib="/farcry/core/tags/formtools" />
<cfimport prefix="skin" taglib="/farcry/core/tags/webskin" />


<!--- data providers --->
<cfset qComments = getComments(objectid=stObj.objectID) />

<cfoutput>
<h3>Reader Comments</h3>
</cfoutput>

<cfoutput><p>#qComments.recordCount# comments posted. <skin:buildLink type="#stobj.typename#" objectid="#stobj.objectid#" urlParameters="postComment=1" anchor="postComment" linktext="Post Comment" /></p></cfoutput>


	
<cfif qComments.recordcount>
	<cfloop query="qComments">
		<skin:view objectID="#qComments.objectID#" typename="farBlogComment" webskin="displayTeaserStandard" />
	</cfloop>
</cfif>


<cfsetting enablecfoutputonly="false" />