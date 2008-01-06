<cfsetting enablecfoutputonly="true" />

<cfset oPost=createObject("component", application.stcoapi["farblogpost"].typepath) />
<cfset stPost=oPost.getData(objectid=stobj.parentid) />

<!--- unsubscribe users email from thread --->
<cfset unsubscribeuser(objectid=stobj.objectid) />

<cfoutput>
<div style="border: ##333 solid 3px; margin: 10% 30%; padding: 30px; background-color: ##ededed;">
	<blockquote>
		<p><strong>#stpost.title#</strong><br /> #stpost.teaser#</p>
	</blockquote>
	<p>
		You have unsubscribed from this blog post.  You will not receive any 
		additional alerts when people comment.  If you would like to re-subscribe 
		you can do so from the blog post comment section.
	</p>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />