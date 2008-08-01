<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Standard page body layout --->
<!--- @@Description: Standard page body display for all farBlog --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfoutput>
	<div class="content">
		
		<h1>			
			<skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.title#" />
		</h1>
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
				#application.config.farcryblog.authorName# : 
				Comments (#getTotalComments(stobj.objectid)#) : <skin:buildlink objectID="#stObj.objectID#" linktext="permalink" /> :
				Categorised: </cfoutput><skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayListCategories" /><cfoutput> :
				Bookmarks: </cfoutput><skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayListBookmarks" /><cfoutput>
			</p>		
		</div>
</cfoutput>
		
		<!--- Comments --->
		<skin:view objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayListComments" />
	
		<!--- Post Comments --->
		<skin:view objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayFormComment" />

<cfoutput>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />