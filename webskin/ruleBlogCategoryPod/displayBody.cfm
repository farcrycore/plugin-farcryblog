<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: ruleBlogCategoryPod Body Display --->
<!--- @@Description: Lists all active blog categories. --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- required attributes --->
<cfparam name="stparam.qcats" type="query" />

<cfoutput>
<div>
	<h3>Categories</h3>
	<ul>
	<cfloop query="stparam.qCats">
	  <li><skin:buildlink objectid="#stparam.qCats.objectid#" linktext="#stparam.qCats.categoryLabel# (#stparam.qCats.assigned#)" /></li>
	</cfloop>
	</ul>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false" />