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
<cfset stLocal.wddxRelatedLinks = application.fapi.getConfig(key="farcryblog", name="wddxRelatedLinks", default="") />

<cfoutput>
<div class="blog-pod">		
	<h3>Related Sites</h3>
	
	<cfif len(stLocal.wddxRelatedLinks) and iswddx(stLocal.wddxRelatedLinks)>
		<cfwddx action="wddx2cfml" input="#stLocal.wddxRelatedLinks#" output="aLinks" />
	</cfif>
	
	<cfif arraylen(aLinks)>
		<ul>
		
		<cfloop from="1" to="#arraylen(aLinks)#" index="i">
			<li><a href="#aLinks[i].URL#" target="_blank">#aLinks[i].label#</a></li>
		</cfloop>
		
		</ul>
	</cfif>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false">