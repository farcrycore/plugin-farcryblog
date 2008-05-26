<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Standard page layout --->
<!--- @@Description: Standard full page display for blog posts --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!-------------------------------
VIEW
-------------------------------->
<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayHeaderStandard" pageTitle="#stObj.title#" />

<cfoutput>
<div class="item">
	<div class="date">
		<div>#dateformat(stObj.publishDate, "MMM")#</div>
		<span>#dateformat(stObj.publishDate, "DD")#</span>
	</div>

	<div class="content">
		<h1></cfoutput><skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.title#" /><cfoutput></h1>

		<div class="body">#stObj.body#
</cfoutput>

		<!--- related blog posts --->
		<skin:relatedContent objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayLink" arrayProperty="aRelatedPosts" rendertype="unordered" filter="farBlogPost" r_html="relatedContent" />
		<cfif structkeyexists(variables, "relatedContent") AND len(relatedContent)>
			<cfoutput>
			<h3>Related Blog Posts</h3>
			#relatedContent#
			</cfoutput>
		</cfif>

		<!--- post footer; author, comments, permalink --->
		<skin:view objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayPostFooter" />

		<cfoutput></div></cfoutput>

		<skin:view objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayComments" />

<cfoutput>
	</div>
</div>

<!-- dpSyntaxHiglighter activation code -->
<script language="javascript" src="/js/dp.SyntaxHighlighter/Scripts/shCore.js"></script>
<script language="javascript" src="/js/dp.SyntaxHighlighter/Scripts/shBrushCSharp.js"></script>
<script language="javascript" src="/js/dp.SyntaxHighlighter/Scripts/shBrushXml.js"></script>
<script language="javascript">
	dp.SyntaxHighlighter.HighlightAll('code');
</script>
</cfoutput>

<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayFooterStandard" />

<cfsetting enablecfoutputonly="false" />