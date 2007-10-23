<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Standard Page --->
<!--- @@Description: Blog Post standard full page display template. --->
<!--- @@Developer: Geoff Bowers (modius@daemon.com.au) --->

<!--- import tag library --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="../../tags" prefix="tag" />


<!------------------------------- 
VIEW
-------------------------------->
<cfmodule 
	template="/farcry/projects/#application.applicationname#/webskin/includes/dmHeader.cfm" 
	pageTitle="#stObj.title#">


<cfoutput>
<div class="item">
	<div class="date">
		<div>#dateformat(stobj.publishdate, "MMM")#</div>
		<span>#dateformat(stobj.publishdate, "DD")#</span>
	</div>
	
	<div class="content">
		<h1></cfoutput><skin:buildlink objectid="#stobj.objectid#" linktext="#stObj.Title#" /><cfoutput></h1>
		
		<div class="body">
			#stObj.body#
			</cfoutput>
			
			<!--- related blog posts --->
			<skin:relatedcontent typename="farBlogPost" objectid="#stobj.objectid#" arrayProperty="aRelatedPosts" webskin="displayLink" rendertype="unordered" filter="farblogpost" r_html="relatedcontent" />
			<cfif isDefined("relatedContent") AND len(relatedcontent)>
				<cfoutput>
				<h3>Related Blog Posts</h3>
				#relatedcontent#
				</cfoutput>
			</cfif>
			
			<!--- post footer; author, comments, permalink --->
			<skin:view typename="farBlogPost" objectid="#stobj.objectid#" webskin="displayPostFooter" />
			
			
			<cfoutput>
		</div>
</cfoutput>
		
<tag:adsense />
<tag:comments postid="#stobj.objectid#" />

<cfoutput>

	</div>
</div>

</cfoutput>

<cfmodule template="/farcry/projects/#application.applicationname#/webskin/includes/dmFooter.cfm">

<cfsetting enablecfoutputonly="no">