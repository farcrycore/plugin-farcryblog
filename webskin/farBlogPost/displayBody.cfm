<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Standard page body layout --->
<!--- @@Description: Standard page body display for all farBlog --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />

<cfset stLocal.stProfile = application.fapi.getContentObject(objectid=stObj.dmProfileID,typename="dmProfile") />


<grid:div style="float:left;width:25%;clear:both;">	
	<cfif len(stObj.farBlogID)>
		<skin:view typeName="farBlog" objectid="#stObj.farBlogID#" webskin="displayPodColumn" />
	</cfif>
</grid:div>

<grid:div style="float:left;width:75%;">
	<grid:div style="padding:5px;">	
	
		<grid:div class="content">
			<cfoutput>
			<h1><skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.title#" /></h1>
			<span class="date">#dateformat(stObj.publishDate, "DD MMM YYYY")#</span>
			<div class="body">
				#stObj.body#
			</cfoutput>	
		
			<cfif isBoolean(stobj.bShowMediaInline) AND stObj.bShowMediaInline>	
				<!--- Display Inline Media --->
				<skin:view typename="farBlogPost" objectID="#stObj.objectID#" webskin="displayListMedia" />
			</cfif>
		
		
			<!--- Related Blog Posts --->
			<skin:view typename="farBlogPost" objectID="#stObj.objectID#" webskin="displayListRelatedPosts" />
		
			<cfoutput>
				<p>
					<skin:buildlink objectID="#stObj.objectID#" linktext="Permalink" /> :
					Author: #stLocal.stProfile.firstname# #stLocal.stProfile.lastname# : 
					Comments (#getTotalComments(stobj.objectid)#) : 
					Filed Under: </cfoutput><skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayListCategories" /><cfoutput>
					<!--- Bookmarks: </cfoutput><skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayListBookmarks" /><cfoutput> --->
				</p>		
			</div>
			</cfoutput>
				
			<!--- Post Comments --->
			<cfif structKeyExists(url, "postComment") and isBoolean(url.postComment) and url.postComment>
				<skin:view objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayFormComment" />
			</cfif>
			<!--- Comments --->
			<skin:view objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayListComments" />
		
		</grid:div>	
	</grid:div>
</grid:div>	



<cfsetting enablecfoutputonly="false" />