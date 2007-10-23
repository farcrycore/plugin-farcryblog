<cfsetting enablecfoutputonly="yes">
<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au $
$License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php$

|| DESCRIPTION || 
$Description: farBlogPost -- standard page with snags and captions$

|| DEVELOPER ||
$Developer: Geoff Bowers (modius@daemon.com.au) $
--->
<!--- @@displayname: Snag Bag Layout --->
<!--- @@author: Geoff Bowers --->

<!--- import tag library --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="../../tags" prefix="tag" />

<cfmodule template="/farcry/projects/#application.applicationname#/webskin/includes/dmHeader.cfm" pageTitle="#stObj.title#">

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

	<cfif arrayLen(stobj.aMedia)>
		<cfset stExtended=getData(objectid=stobj.objectid, bArraysAsStructs=true) />
		<cfloop from="1" to="#arrayLen(stExtended.aMedia)#" index="i">
			<cfset oType=createobject("component", application.types[stExtended.aMedia[i].typename].typepath) />
			<cfset HTML=oType.getView(objectid=stExtended.aMedia[i].data, template="displayImageWithCaption") />
			<cfoutput>#HTML#</cfoutput>
		</cfloop>
	</cfif>	
		
			
<cfoutput>			
			<p>&nbsp;</p>
			</cfoutput>
			
			<skin:view typename="farBlogPost" objectid="#stobj.objectid#" webskin="displayPostFooter" />
			
			<cfoutput>
		</div>
</cfoutput>
		
		<tag:adsense />

		<tag:comments postid="#stobj.objectid#"/>

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

<cfmodule template="/farcry/projects/#application.applicationname#/webskin/includes/dmFooter.cfm">

<cfsetting enablecfoutputonly="no">