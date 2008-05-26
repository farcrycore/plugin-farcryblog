<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display comment unsubscription page --->
<!--- @@Description: Display unsubscribe page for a blog comment content item in the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<cfset oPost=createobject("component", application.stCOAPI["farBlogPost"].typepath) />
<cfset stPost=oPost.getData(objectID=stObj.parentID) />

<!--- unsubscribe users email from thread --->
<cfset unsubscribeUser(objectID=stObj.objectID) />

<cfoutput>
<div style="border: ##333 solid 3px; margin: 5% 30%; padding: 30px; background-color: ##ededed;">
	<h3>#application.config.farcryblog.blogTitle#</h3>
	<p>Unsubscribing <strong>#stObj.email#</strong> from:</p>
	<blockquote>
		<p><strong>#stPost.title#</strong><br /> #stPost.teaser#</p>
	</blockquote>
	<p>
		You have unsubscribed from this blog post.  You will not receive any
		additional alerts when people comment.  If you would like to re-subscribe
		you can do so from the blog post comment section.
	</p>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />