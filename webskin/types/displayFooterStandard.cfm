<cfsetting enablecfoutputonly="true">

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />
<cfimport taglib="/farcry/plugins/farcryblog/tags" prefix="blog" />

<grid:container>
	<grid:col id="footer" span="24">
		
		 <skin:genericNav navID="#application.navid.footer#"
			id="nav"
			depth="1"
			bActive="true"
			bIncludeHome="false">
			
	</grid:col>
</grid:container>

<!--- load blog specific customisations; must run just before closing /body of skin --->
<blog:foot />

<cfoutput>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="false">