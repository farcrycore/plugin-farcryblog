<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Subscribe Pod --->
<!--- @@description:   --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>
<cfoutput>
<div class="blog-pod">
	<h3>Subscribe</h3>
	
	<ul>
		<li><skin:buildLink type="#stobj.typename#" objectid="#stobj.objectid#" view="displayRSS" target="subscribe" linktext="rss" /></li>
	</ul>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false">