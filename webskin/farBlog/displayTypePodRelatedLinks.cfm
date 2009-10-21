<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Related Links --->
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
<cfset stLocal.lRelatedLinks = application.fapi.getConfig(key="farcryblog", name="relatedLinks", default="") />

<cfoutput>
<div class="blog-pod">		
	<h3>Related links</h3>
	<cfif listLen(stLocal.lRelatedLinks)>
		<ul>
		
		<cfloop list="#stLocal.lRelatedLinks#" index="i">
			<li><a href="#i#">#i#</a></li>
		</cfloop>
		
		</ul>
	</cfif>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false">