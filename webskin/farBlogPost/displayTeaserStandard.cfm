<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Display post teaser --->
<!--- @@Description: Default farcryblog standard teaser for blog posts --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />


<!-----------------------------
 VIEW 
------------------------------>
<cfoutput>
<div class="item">
	<div class="date">
		<div>#dateformat(stObj.publishDate, "MMM")#</div>
		<span>#dateformat(stObj.publishDate, "DD")#</span>
	</div>
	<div class="content">
		<h1><skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.title#" /></h1>
		<div class="body">
			<p>#stObj.teaser#</p>
			
			<cfif arraylen(stobj.aMedia)>
				<skin:view objectid="#stobj.aMedia[1]#" webskin="displayMedia" alternateHTML="<p>--- No Media View of this item available ---</p>" />
			</cfif>

			<p><skin:buildlink objectID="#stObj.objectID#" linktext="More on this post..." /></p>

			<p>#application.config.farcryblog.authorName# : Comments (#getTotalComments(stobj.objectid)#) : <skin:buildlink objectID="#stObj.objectID#" linktext="permalink" /></p>		

		</div>

	</div>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false" />