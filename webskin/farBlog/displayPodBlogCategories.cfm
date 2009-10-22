<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Links to the blogs categories --->
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



<cfif listLen(stobj.lCategories)>
	<cfoutput>
	<div class="blog-pod">
		<h3>Categories</h3>
		<ul>
			<cfloop list="#stobj.lCategories#" index="i">
				<li><skin:buildLink type="#stobj.typename#" objectid="#stobj.objectID#" bodyView="displayBodyCategoryFilter" urlParameters="cat=#i#">#i#</skin:buildLink></li>
			</cfloop>
		</ul>
	</div>
	</cfoutput>
</cfif>


<cfsetting enablecfoutputonly="false">