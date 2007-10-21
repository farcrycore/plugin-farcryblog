<cfsetting enablecfoutputonly="true" />
<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au $

|| DESCRIPTION || 
$Description: webskin footer $

|| DEVELOPER ||
$Developer: Geoff Bowers (modius@daemon.com.au)$
--->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/container" prefix="con" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />


<cfoutput>
	</div>
	<!--- /close class="main" --->

	<div class="navigation">
		
		<center>
		<a href="http://www.farcrycms.org/"><img src="/wsimages/farcryAdBadge120x90.gif" border="0" /></a>
		<a href="http://www.adobemax2007.com/na/sessions/locator/session/RA038W"><img border="0" src="http://adobemax2007.com/banners/MAX07_B125x125_speaker.gif"/></a>
		</center>
		
		<h1>Places to Go</h1>
		</cfoutput><skin:genericnav /><cfoutput>

		<!--- <h1>Another thing</h1>
		<ul>
			<li><a href="index.html">consequat molestie</a></li>
			<li><a href="index.html">sem justo</a></li>
			<li><a href="index.html">semper</a></li>
			<li><a href="index.html">sociis natoque</a></li>
		</ul>

		<h1>Third and last</h1>
		<ul>
			<li><a href="index.html">sociis natoque</a></li>
			<li><a href="index.html">magna sed purus</a></li>
			<li><a href="index.html">tincidunt</a></li>
			<li><a href="index.html">consequat molestie</a></li>
		</ul> --->

		<h1>Ancient Category Archives</h1>
		<ul>
			<li><a href="archives/cat_breeze.html">Breeze</a></li>
			<li><a href="archives/cat_cfeclipse.html">CFEclipse</a></li>
			<li><a href="archives/cat_cvs.html">CVS</a></li>
			<li><a href="archives/cat_central.html">Central</a></li>
			<li><a href="archives/cat_coldfusionmx.html">ColdFusionMX</a></li>
			<li><a href="archives/cat_connected.html">Connected</a></li>
			<li><a href="archives/cat_database.html">Database</a></li>
			<!--- <li><a href="archives/cat_farcry.html">FarCry</a></li> --->
			<li><a href="archives/cat_flash_remoting.html">Flash Remoting</a></li>
			<li><a href="archives/cat_flashmx.html">FlashMX</a></li>
			<li><a href="archives/cat_flex.html">Flex</a></li>
			<li><a href="archives/cat_fullasagoog.html">Fullasagoog</a></li>
			<li><a href="archives/cat_information_architecture.html">Information Architecture</a></li>
			<li><a href="archives/cat_java.html">Java</a></li>
			<li><a href="archives/cat_opensource.html">Opensource</a></li>
			<li><a href="archives/cat_robodemo.html">RoboDemo</a></li>
			<li><a href="archives/cat_snippets.html">Snippets</a></li>
			<li><a href="archives/cat_spectra.html">Spectra</a></li>
			<li><a href="archives/cat_standards.html">Standards</a></li>
		</ul>
		
	</div>
	<!--- /close class="navigation" --->

	<div class="clearer"><span></span></div>
	<div class="footer">
		&copy; 2002-2007 <a href="http://www.daemon.com.au/">www.daemon.com.au</a>. Built on the <a href="http://www.farcrycms.org/">FarCry Framework</a>. Template design by <a href="http://templates.arcsin.se">Arcsin</a>
	</div>

</div>
<!--- /close class="main" --->

<!--- google analytics activation code --->
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
<script type="text/javascript">
_uacct = "UA-137466-1";
urchinTracker();
</script>

<!-- dpSyntaxHiglighter activation code -->
<script language="javascript" src="/js/dp.SyntaxHighlighter/Scripts/shCore.js"></script>
<script language="javascript" src="/js/dp.SyntaxHighlighter/Scripts/shBrushCSharp.js"></script>
<script language="javascript" src="/js/dp.SyntaxHighlighter/Scripts/shBrushXml.js"></script>
<script language="javascript">
	dp.SyntaxHighlighter.HighlightAll('code');
</script>
</body>
</html>
</cfoutput>


<!--- 
<cfoutput>
	<div id="sidebar">
	<a href="http://www.webdu.com.au/"><img src="/wsimages/banner_180x150.jpg" style="margin: 10px 0px 10px 15px;" /></a>
</cfoutput>

sidebar container: Recent Entries
<con:container label="#request.stobj.objectID#_sidebar" defaultMirrorLabel="Recent Entries">

<cfoutput>
		<h2>Category Archives</h2>
		<p>
			<a href="archives/cat_breeze.html">Breeze</a> (7)<br />
			<a href="archives/cat_cfeclipse.html">CFEclipse</a> (1)<br />
			<a href="archives/cat_cvs.html">CVS</a> (6)<br />
			<a href="archives/cat_central.html">Central</a> (12)<br />
			<a href="archives/cat_coldfusionmx.html">ColdFusionMX</a> (91)<br />
			<a href="archives/cat_connected.html">Connected</a> (24)<br />
			<a href="archives/cat_database.html">Database</a> (1)<br />
			<a href="archives/cat_farcry.html">FarCry</a> (20)<br />
			<a href="archives/cat_flash_remoting.html">Flash Remoting</a> (18)<br />
			<a href="archives/cat_flashmx.html">FlashMX</a> (45)<br />
			<a href="archives/cat_flex.html">Flex</a> (10)<br />
			<a href="archives/cat_fullasagoog.html">Fullasagoog</a> (13)<br />
			<a href="archives/cat_information_architecture.html">Information Architecture</a> (9)<br />
			<a href="archives/cat_java.html">Java</a> (13)<br />
			<a href="archives/cat_opensource.html">Opensource</a> (9)<br />
			<a href="archives/cat_robodemo.html">RoboDemo</a> (1)<br />
			<a href="archives/cat_snippets.html">Snippets</a> (37)<br />
			<a href="archives/cat_spectra.html">Spectra</a> (6)<br />
			<a href="archives/cat_standards.html">Standards</a> (1)<br />
		</p>

		<h2>Blog Roll</h2>
		<p><a href="http://www.fullasagoog.com/"><b>Full As A Goog</b></a><br />
		They're all here in the Goog really -- why go anywhere else?</p>
		<h2>Projects We Support</h2>
		<p>
			<a href="http://www.farcrycms.org/">FarCry CMS Opensource</a><br />
			<a href="http://www.daemon.com.au/">Daemon Internet Consultants</a><br />
			<a href="http://www.cfug.org.au/">CFUG Australia</a><br />
			<a href="http://lists.daemon.com.au/">MX Aussie Mailing Lists</a><br />
		</p>
		<h2>Monthly Archives</h2>
		<p>
		
			<a href="archives/2005_10.html">October 2005</a><br />
		
			<a href="archives/2005_09.html">September 2005</a><br />
		
			<a href="archives/2005_08.html">August 2005</a><br />
		
			<a href="archives/2005_07.html">July 2005</a><br />
		
			<a href="archives/2005_06.html">June 2005</a><br />
		
			<a href="archives/2005_05.html">May 2005</a><br />
		
			<a href="archives/2005_04.html">April 2005</a><br />
		
			<a href="archives/2005_03.html">March 2005</a><br />
		
			<a href="archives/2005_02.html">February 2005</a><br />
		
			<a href="archives/2005_01.html">January 2005</a><br />
		
			<a href="archives/2004_12.html">December 2004</a><br />
		
			<a href="archives/2004_11.html">November 2004</a><br />
		
			<a href="archives/2004_10.html">October 2004</a><br />
		
			<a href="archives/2004_09.html">September 2004</a><br />
		
			<a href="archives/2004_08.html">August 2004</a><br />
		
			<a href="archives/2004_07.html">July 2004</a><br />
		
			<a href="archives/2004_06.html">June 2004</a><br />
		
			<a href="archives/2004_05.html">May 2004</a><br />
		
			<a href="archives/2004_04.html">April 2004</a><br />
		
			<a href="archives/2004_03.html">March 2004</a><br />
		
			<a href="archives/2004_02.html">February 2004</a><br />
		
			<a href="archives/2004_01.html">January 2004</a><br />
		
			<a href="archives/2003_12.html">December 2003</a><br />
		
			<a href="archives/2003_11.html">November 2003</a><br />
		
			<a href="archives/2003_10.html">October 2003</a><br />
		
			<a href="archives/2003_09.html">September 2003</a><br />
		
			<a href="archives/2003_08.html">August 2003</a><br />
		
			<a href="archives/2003_07.html">July 2003</a><br />
		
			<a href="archives/2003_06.html">June 2003</a><br />
		
			<a href="archives/2003_05.html">May 2003</a><br />
		
			<a href="archives/2003_04.html">April 2003</a><br />
		
			<a href="archives/2003_03.html">March 2003</a><br />
		
			<a href="archives/2003_02.html">February 2003</a><br />
		
			<a href="archives/2003_01.html">January 2003</a><br />
		
			<a href="archives/2002_12.html">December 2002</a><br />
		
			<a href="archives/2002_11.html">November 2002</a><br />
		
			<a href="archives/2002_10.html">October 2002</a><br />
		
			<a href="archives/2002_09.html">September 2002</a><br />
		
			<a href="archives/2002_08.html">August 2002</a><br />
		
			<a href="archives/2002_07.html">July 2002</a><br />
		
			<a href="archives/2002_06.html">June 2002</a><br />
		
			<a href="archives/2002_04.html">April 2002</a><br />
		
		</p>
		<h2>Syndicate This Site</h2>
		<p>
			<a href="/xml/rss20.xml">RSS 2.0</a><br />
		</p>
		<h2>Powered By</h2>
		<p>
			<a href="http://www.farcrycms.org/">FarCry CMS</a><br />
			<a href="http://www.daemon.com.au/">Daemon Intuition</a><br />
		</p>
	</div>
	<br class="bottom" />
</div>
<div id="pagefoot">
	<a href="http://www.daemon.com.au/">Daemon Internet Consultants</a>. 2003. All rights reserved.<br />
	Serious web solutions.  The Adobe specialists.
</div>
</body>

</html>
</cfoutput>
 --->
<cfsetting enablecfoutputonly="no">