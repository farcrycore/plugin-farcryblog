<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Execution of ruleBlogCategoryPod --->
<!--- @@Description: Lists all active blog categories. --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<cfset oCat=createObject("component", application.stcoapi["farblogcategory"].typepath) />
<cfset qCats=oCat.getActiveCategories() />

<cfoutput>
<div>
	<h3>Categories</h3>
	<ul>
	<cfloop query="qCats">
	  <li><skin:buildlink objectid="#qCats.objectid#" linktext="#qCats.title# (#qCats.assigned#)" /></li>
	</cfloop>
	</ul>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false" />