<cfsetting enablecfoutputonly="true">

<!--- IMPORT TAG LIBRARIES --->
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />

<grid:container>
	<grid:col id="footer" span="24">
		
		 <skin:genericNav navID="#application.navid.footer#"
			id="nav"
			depth="1"
			bActive="true"
			bIncludeHome="false">
			
	</grid:col>
</grid:container>

<cfoutput>
</body>
</html>
</cfoutput>

<cfsetting enablecfoutputonly="false">