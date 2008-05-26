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
<cfset oComment = createobject("component", application.stCOAPI["farBlogComment"].packagepath) />
<cfset qComments = oComment.getComments(parentID=stObj.objectID) />

<cfif qComments.recordcount>

	<cfoutput>
	<h3>Reader Comments</h3>
	</cfoutput>

	<cfloop query="qComments">
		<skin:view objectID="#qComments.objectID#" typename="farBlogComment" webskin="displayTeaserStandard" />
	</cfloop>

</cfif>

<!--- comments form --->
<cfset stProps = structnew() />
<cfset stProps.parentID = stObj.objectID />
<cfset stProps.bSubscribe = 0 />

<skin:view typename="farBlogComment" template="displayCommentForm" stProps="#stProps#" />

<cfsetting enablecfoutputonly="false" />