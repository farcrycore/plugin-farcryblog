<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Archive Blog Teaser  --->

<!--- import tag libraries --->
<cfimport prefix="skin" taglib="/farcry/core/tags/webskin">

<cfoutput>
<div class="archive">
	<skin:buildlink objectid="#stobj.objectid#" linktext='<h3 class="title">#stobj.title#</h3>' />
	<span class="date">#dateformat(stObj.publishDate, "DD MMM YYYY")#</span>
	<p>#stObj.Teaser#</p>
	<p>#application.config.farcryblog.authorName# : Comments (#getTotalComments(stobj.objectid)#) : <skin:buildlink objectID="#stObj.objectID#" linktext="permalink" /></p>		
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />
