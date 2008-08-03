<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Add Comment Form --->
<!--- @@description: Displays the add comment form if commenting is turned on.  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>

<!--- ONLY ALLOW NEW COMMENTS IF COMMENTING TURNED ON. --->
<cfif stobj.bcomment>
	<!--- comments form --->
	<cfset stLocal.stProps = structnew() />
	<cfset stLocal.stProps.parentID = stObj.objectID />
	<cfset stLocal.stProps.bSubscribe = 0 />
	<cfif application.security.isLoggedIn()>
		<!--- Set this comment details for the member --->
		<cfset stLocal.stProps.profileID = session.dmProfile.objectid />
		<cfset stLocal.stProps.commentHandle = "#session.dmProfile.firstname# #session.dmProfile.lastname#" />
		<cfset stLocal.stProps.email = session.dmProfile.emailAddress />
	</cfif>
	
	
	<skin:view typename="farBlogComment" template="displayFormComment" stProps="#stLocal.stProps#" />
</cfif>

<cfsetting enablecfoutputonly="false">