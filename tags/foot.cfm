<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Load Head/Foot --->
<!--- @@description: Load any blog instance specific head and footer markup and scripts.  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/plugins/farcryblog/tags" prefix="blog" />

<!--- run once only --->
<cfif thisTag.executionMode EQ "end">
	<cfsetting enablecfoutputonly="false">
	<cfexit method="exittag" />
</cfif>

<!--- load blog specific js libraries --->
<blog:dpSyntaxHighlighter />
<blog:swfobject />

<cfsetting enablecfoutputonly="false" />