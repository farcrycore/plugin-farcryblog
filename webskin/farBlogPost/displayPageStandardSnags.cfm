<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Snag bag layout --->
<!--- @@Description: Snag bag full page display for blog posts --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="../../tags" prefix="tag" />

<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayHeaderStandard" pageTitle="#stObj.title#" />

<cfoutput>
<div class="item">
	<div class="date">
		<div>#dateformat(stObj.publishDate, "MMM")#</div>
		<span>#dateformat(stObj.publishDate, "DD")#</span>
	</div>
	<div class="content">
		<h1></cfoutput><skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.Title#" /><cfoutput></h1>
		<div class="body">#stObj.body#
</cfoutput>

		<cfif arraylen(stObj.aMedia)>
			<cfset stExtended = getData(objectID=stObj.objectID, bArraysAsStructs=true) />
			<cfloop from="1" to="#arraylen(stExtended.aMedia)#" index="i">
				<skin:view objectID="#stExtended.aMedia[i].data#" typename="#stExtended.aMedia[i].typename#" webskin="displayImageWithCaption" />
			</cfloop>
		</cfif>

		<cfoutput><p>&nbsp;</p></cfoutput>

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