<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Archive Blog Teaser  --->

<cfimport prefix="skin" taglib="/farcry/core/tags/webskin">
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<cfoutput>
<div class="article">
	<skin:buildlink objectid="#stobj.objectid#" linktext='<h3 class="title">#stobj.title#</h3>' />
	<div class="body">
		<p>#stObj.Teaser#</p>
	</div>
	<p>#application.config.farcryblog.authorName# : Comments (#getTotalComments(stobj.objectid)#) : <skin:buildlink objectID="#stObj.objectID#" linktext="permalink" /></p>		
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />
