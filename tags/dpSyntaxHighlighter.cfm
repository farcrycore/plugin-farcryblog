<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Load DP Syntax Highlighter --->
<!--- @@description: Syntax Highlighting of code snippets  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!--- run once only --->
<cfif thisTag.executionMode EQ "end">
	<cfsetting enablecfoutputonly="false">
	<cfexit method="exittag" />
</cfif>

<!--- optional attributes --->
<cfparam name="attributes.dpURL" default="#application.url.webroot#/farcryblog/js/dp.SyntaxHighlighter" />
<cfparam name="attributes.brushes" default="shBrushCSharp,shBrushXml" />


<skin:htmlHead id="dpSyntaxHighlighter">
<cfoutput>
<!-- dpSyntaxHiglighter activation code -->
<link type="text/css" rel="stylesheet" href="#attributes.dpURL#/Styles/SyntaxHighlighter.css"></link>
<script type="text/javascript" src="#attributes.dpURL#/Scripts/shCore.js"></script>
<cfloop list="#attributes.brushes#" index="brush">
<script type="text/javascript" src="#attributes.dpURL#/Scripts/#brush#.js"></script>
</cfloop>
<script type="text/javascript">
window.onload = function () {
    dp.SyntaxHighlighter.ClipboardSwf = '#attributes.dpURL#/Scripts/clipboard.swf';
    dp.SyntaxHighlighter.HighlightAll('code');
}
</script>
</cfoutput>
</skin:htmlHead>

<cfsetting enablecfoutputonly="false" />