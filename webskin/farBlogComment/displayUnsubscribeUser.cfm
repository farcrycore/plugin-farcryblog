<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Display comment unsubscription page --->
<!--- @@Description: Display unsubscribe page for a blog comment content item in the FarCry Blog plugin --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" /> 

<cfset oPost=createobject("component", application.stCOAPI["farBlogPost"].packagePath) />
<cfset stPost=oPost.getData(objectID=stObj.parentID) />

<!--- unsubscribe users email from thread --->
<cfset unsubscribeUser(objectID=stObj.objectID) />


<skin:view typename="farBlogPost" objectid="#stPost.objectid#" webskin="displayTeaserStandard" />

<cfoutput>
	<p>Unsubscribing <strong>#stObj.email#</strong></p>
	<p>
		You have unsubscribed from this blog post.  You will not receive any
		additional alerts when people comment.  If you would like to re-subscribe
		you can do so from the blog post comment section.
	</p>
</cfoutput>
<cfsetting enablecfoutputonly="false" />