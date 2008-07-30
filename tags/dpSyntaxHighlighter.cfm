<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: DP Syntax Highlighter --->
<!--- @@description: Syntax Highlighting of code snippets  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->

<cfif thisTag.executionMode EQ "end">
	<cfsetting enablecfoutputonly="false">
	<cfexit method="exittag" />
</cfif>

<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<skin:htmlHead id="bpSyntaxHighlighter">
<cfoutput>
<!-- dpSyntaxHiglighter activation code -->
<script language="javascript" src="#application.url.webroot#/farcryblog/js/dp.SyntaxHighlighter/Scripts/shCore.js"></script>
<script language="javascript" src="#application.url.webroot#/farcryblog/js/dp.SyntaxHighlighter/Scripts/shBrushCSharp.js"></script>
<script language="javascript" src="#application.url.webroot#/farcryblog/js/dp.SyntaxHighlighter/Scripts/shBrushXml.js"></script>
<script language="javascript">
	dp.SyntaxHighlighter.HighlightAll('code');
</script>
</cfoutput>
</skin:htmlHead>

<cfsetting enablecfoutputonly="false">