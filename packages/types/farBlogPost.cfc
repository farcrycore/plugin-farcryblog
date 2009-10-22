<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Post --->
<!--- @@Description: Blog post type component for the FarCry Blog plugin --->
<cfcomponent displayname="Blog Post" extends="farcry.core.packages.types.versions" bSchedule="true" bFriendly="true" bObjectBroker="true" lObjectBrokerWebskins=""
	hint="Manage your blog posts, create new missives, edit the HTML of individual posts, categorise posts by topic and schedule posts for future dates.">

	<!--- properties --->
	<cfproperty 
		name="Title" type="string" required="true" default="" hint="Blog post title." 
		ftSeq="1" ftWizardStep="Start" ftFieldset="General Details" ftLabel="Title" ftValidation="required" />
	
	<cfproperty 
		name="publishDate" type="date" required="false" default="" hint="The date that a blog post is sent live and appears on the public website" 
		ftSeq="3" ftWizardStep="Start" ftFieldset="General Details" ftLabel="Publish Date" 
		ftType="datetime" ftDefaultType="evaluate" ftDefault="now()" ftDateFormatMask="dd mmm yyyy" ftTimeFormatMask="hh:mm tt" ftToggleOffDateTime="false" />
	
	<cfproperty 
		name="displayMethod" type="string" required="true" default="displayPageStandard" hint="Display method to render." 
		ftSeq="5" ftWizardStep="Start" ftFieldset="General Details" ftLabel="Content Template" 
		ftType="webskin" ftPrefix="displayPage" ftDefault="displayPageStandard" />
	
	<cfproperty ftseq="6" type="string" ftfieldset="General Details" ftlabel="Email Address"
		name="email" default="" hint="" ftvalidation="" ftWatch="dmProfileID"
		fttype="string" fthint="You will be sent a notification to this email address when comments are made."/>
	
	<cfproperty 
		name="bComment" type="boolean" required="true" default="1" hint="Flag for enabling comments."
		ftSeq="7" ftWizardStep="Start" ftFieldset="General Details" ftLabel="Enable Comments" />
		
	<cfproperty
		name="bAutoPublish" type="boolean" required="true" default="1" hint="Flag for auto-publishing comments." 
		ftSeq="8" ftWizardStep="Start" ftFieldset="General Details" ftLabel="Auto Publish Comments" />
	
	<cfproperty ftseq="9" type="boolean" ftfieldset="General Details" ftlabel="Email Notification"
		name="bEmailNotification" default="0" hint="Only used if bEnablecomments is true" ftvalidation="" 
		fttype="list" ftList="1:Email me a notification when ever a comment is posted,0:Do not notify me" ftrendertype="radio" fthint=""/>
	
	<cfproperty 
		name="catBlogPost" type="longchar" hint="Blog categorisation." 
		ftSeq="10" ftWizardStep="Start" ftFieldset="Categorisation" ftLabel="Categories"
		ftType="category" ftAlias="farBlogPost" />
		
		
	<cfproperty 
		name="lCategories" type="longchar" hint="Blog categorisation." 
		ftSeq="10" ftWizardStep="Start" ftFieldset="Categorisation" ftLabel="Categories"
		ftType="list" 
			ftListData="getBlogPostCategories" ftListDataTypename="farBlogPost"
			ftSelectMultiple="true" />
		
	
	<cfproperty
		name="Body" type="longchar" required="false" default="" hint="Main body of content." 
		ftSeq="21" ftWizardStep="Blog Post" ftFieldset="Blog Details" ftLabel="Blog Post" 
		ftType="richtext" ftTemplateTypeList="dmImage,dmFile,dmFlash,dmNavigation,dmHTML" />
	
	<cfproperty 
		name="Teaser" type="longchar" required="false" default="" hint="Teaser text." 
		ftSeq="23" ftWizardStep="Blog Post" ftFieldset="Blog Details" ftLabel="Teaser" />
	
	<cfproperty 
		name="teaserImage" type="string" required="false" default="" hint="Teaser image." 
		ftSeq="24" ftWizardStep="Blog Post" ftFieldset="Blog Details" ftLabel="Teaser Image"
		ftType="image" ftDestination="/images/farBlogPost/teaser" ftImageWidth="64" ftImageHeight="64" ftAutoGenerateType="pad" />
	
	<cfproperty 
		name="aMedia" type="array" required="false" default="" hint="Mixed media content for this content." 
		ftSeq="25" ftWizardStep="Blog Post" ftFieldset="Related Content" ftLabel="Media Library" 
		ftJoin="dmImage,dmFile,dmFlash" />
	
	<cfproperty 
		name="aObjectIDs" type="array" required="false" default="" hint="Related content." 
		ftSeq="26" ftWizardStep="Blog Post" ftFieldset="Related Content" ftLabel="Related Internal Links" 
		ftJoin="dmNavigation" />
	
	<cfproperty 
		name="wddxRelatedLinks" type="longchar" required="false" default="" hint="" 
		ftSeq="27" ftWizardStep="Blog Post" ftFieldset="Related Content" ftLabel="Related External Links" />
	
	<cfproperty 
		name="bShowMediaInline" type="boolean" required="true" default="0" hint="Flag for showing media incline." 
		ftSeq="28" ftWizardStep="Blog Post" ftFieldset="Related Content" ftLabel="Show Media Inline?" />
		
	<cfproperty 
		name="aRelatedPosts" type="array" required="false" default="" hint="Related blog posts." 
		ftSeq="29" ftWizardStep="Blog Post" ftFieldset="Related Content" ftLabel="Related Blog Posts" 
		ftJoin="farBlogPost" />
	
	
	<!--- hidden attribute --->
	<cfproperty 
		name="lMedia" type="string" required="false" default="" hint="Mixed media content for this content." 
		ftType="arrayList" ftArrayField="aMedia" />
	
	<cfproperty ftWizardStep="Blog Post" ftFieldset="Blog" ftLabel="Blog" 
		name="farBlogID" type="uuid" required="true" default="" hint="The blog this post is listed under"
		ftType="uuid" ftJoin="farBlog" ftRenderType="list" />
	
	<cfproperty ftWizardStep="Blog Post" ftFieldset="Blog" ftLabel="Author" 
		name="dmProfileID" type="string" required="true" default="" hint="The blog this post is listed under"
		ftType="list" ftJoin="dmProfile" ftListData="getAuthors" />
	
	<!--- system attribute --->
	<cfproperty 
		name="status" type="string" required="true" default="draft" hint="Status of the node (draft, pending, approved)." />

	<!--- Custom property handlers --->
	<cffunction name="ftEditwddxRelatedLinks" access="public" output="false" returntype="string" hint="his will return a string of formatted HTML text to enable the user to edit the data">
		<cfargument name="typename" required="true" type="string" hint="The name of the type that this field is part of.">
		<cfargument name="stObject" required="true" type="struct" hint="The object of the record that this field is part of.">
		<cfargument name="stMetadata" required="true" type="struct" hint="This is the metadata that is either setup as part of the type.cfc or overridden when calling ft:object by using the stMetadata argument.">
		<cfargument name="fieldname" required="true" type="string" hint="This is the name that will be used for the form field. It includes the prefix that will be used by ft:processform.">
		
		<cfset var html = "" />
		<cfset var aLinks = arraynew(1) />
		<cfset var i = 0 />
		
		<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
		
		<cfif len(arguments.stMetadata.value) and iswddx(arguments.stMetadata.value)>
			<cfwddx action="wddx2cfml" input="#arguments.stMetadata.value#" output="aLinks" />
		</cfif>
		
		<skin:htmlHead library="jqueryjs" />
		<skin:htmlHead><cfoutput>
			<script type="text/javascript">
				function addLinkItem(id,label,url){
					var jLen = jQ("##"+id+"length");
					var jAddLink = jQ("##"+id+"addlinks");
					
					jLen.val(parseInt(jLen.val())+1);
					
					jAddLink.before("<tr id='"+id+"link"+jLen.val()+"' class='relatedlink'><td><input type='text' name='"+id+"label"+jLen.val()+"' id='"+id+"label"+jLen.val()+"' value='"+label+"' /></td><td><input type='text' name='"+id+"url"+jLen.val()+"' id='"+id+"url"+jLen.val()+"' value='"+url+"' /></td><td style='text-align:right;'><a href='##' class='removelink' title='Remove' onclick='jQ(this).parents(\"tr.relatedlink\").remove();return false;'><img src='#application.url.webtop#/facade/icon.cfm?icon=delete&size=16' alt='Remove' /></a></td></tr>");
				};
			</script>
		</cfoutput></skin:htmlHead>
		
		<cfsavecontent variable="html">
			<cfoutput>
				<input type="hidden" name="#arguments.fieldname#" value=" " />
				<input type="hidden" name="#arguments.fieldname#length" id="#arguments.fieldname#length" value="0" />
				<table id="#arguments.fieldname#links" class="relatedlinks" style="width:99%;">
					<tr>
						<th>Label</th>
						<th>URL</th>
						<th>&nbsp;</th>
					</tr>
					<cfloop from="1" to="#arraylen(aLinks)#" index="i">
						<tr id='#arguments.fieldname#link#i#' class='relatedlink'>
							<td><input type='text' name='#arguments.fieldname#label#i#' id='#arguments.fieldname#label#i#' value='#aLinks[i].label#' /></td>
							<td><input type='text' name='#arguments.fieldname#url#i#' id='#arguments.fieldname#url#i#' value='#aLinks[i].url#' /></td>
							<td style='text-align:right;'>
								<a href='##' class='removelink' title='Remove' onclick='jQ(this).parents("tr.relatedlink").remove();return false;'>
									<img src='#application.url.webtop#/facade/icon.cfm?icon=delete&size=16' alt='Remove' />
								</a>
							</td>
						</tr>
					</cfloop>
					<tr id="#arguments.fieldname#addlinks" class="relatedlink">
						<td><a href="##" class="addlink" onclick='addLinkItem("#arguments.fieldname#","","");return false;'><span>add link</span></a></td>
						<td></td>
						<td style="text-align:right;"><a href='##' class='addlink' title='Add' onclick='addLinkItem("#arguments.fieldname#","","");return false;'><img src='#application.url.webtop#/facade/icon.cfm?icon=add&size=16' alt='Add' /></a></td>
					</tr>
				</table>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="ftValidateWDDXRelatedLinks" access="public" output="true" returntype="struct" hint="This will return a struct with bSuccess and stError">
		<cfargument name="stFieldPost" required="true" type="struct" hint="The fields that are relevent to this field type.">
		<cfargument name="stMetadata" required="true" type="struct" hint="This is the metadata that is either setup as part of the type.cfc or overridden when calling ft:object by using the stMetadata argument.">
		
		<cfset var stResult = structnew() />
		<cfset var aLinks = arraynew(1) />
		<cfset var i = 0 />
		<cfset var stLink = structnew() />
		
		<cfset stResult.bSuccess = true>
		<cfset stResult.value = "">
		<cfset stResult.stError = StructNew()>
		
		<cfif structkeyexists(arguments.stFieldPost.stSupporting,"length")>
			<cfloop from="1" to="#arguments.stFieldPost.stSupporting.length#" index="i">
				<cfif structkeyexists(arguments.stFieldPost.stSupporting,"label#i#") and len(arguments.stFieldPost.stSupporting["label#i#"]) and
					  structkeyexists(arguments.stFieldPost.stSupporting,"url#i#") and len(arguments.stFieldPost.stSupporting["url#i#"])>
					<cfset stLink = structnew() />
					<cfset stLink.label = arguments.stFieldPost.stSupporting["label#i#"] />
					<cfset stLink.url = arguments.stFieldPost.stSupporting["url#i#"] />
					<cfset arrayappend(aLinks,stLink) />
				</cfif>
			</cfloop>
			
			<cfwddx action="cfml2wddx" input="#aLinks#" output="stResult.value" />
		</cfif>
		
		<cfreturn stResult />
	</cffunction>
	
	<cffunction name="ftEditEmail" access="public" output="false" returntype="string" hint="his will return a string of formatted HTML text to enable the user to edit the data">
		<cfargument name="typename" required="true" type="string" hint="The name of the type that this field is part of.">
		<cfargument name="stObject" required="true" type="struct" hint="The object of the record that this field is part of.">
		<cfargument name="stMetadata" required="true" type="struct" hint="This is the metadata that is either setup as part of the type.cfc or overridden when calling ft:object by using the stMetadata argument.">
		<cfargument name="fieldname" required="true" type="string" hint="This is the name that will be used for the form field. It includes the prefix that will be used by ft:processform.">
		
		<cfset var stProfile = structnew() />
		
		<cfif structkeyexists(arguments.stObject,"dmProfileID")>
			<cfset stProfile = application.fapi.getContentObject(objectid=arguments.stObject.dmProfileID,typename="dmProfile") />
			<cfif len(stProfile.emailaddress) and not listcontains(arguments.stMetadata.value,stProfile.emailaddress)>
				<cfset arguments.stMetadata.value = listappend(arguments.stMetadata.value,stProfile.emailaddress) />
				<cfset arguments.stObject.email = arguments.stMetadata.value />
			</cfif>
		</cfif>
		
		<cfreturn application.formtools[arguments.stMetadata.ftType].oFactory.edit(argumentCollection=arguments) />
	</cffunction>
	

	<!--- methods --->
	<cffunction name="getAuthors" access="public" output="false" returntype="string" hint="Returns the authors allowed for this object">
		<cfargument name="objectid" type="uuid" required="true" hint="The post to get authors for" />
		
		<cfset var stPost = getData(objectid=arguments.objectid) />
		<cfset var qAuthors = "" />
		<cfset var result = "" />
		
		<cfquery datasource="#application.dsn#" name="qAuthors">
			select		objectid,firstname,lastname
			from		#application.dbowner#dmProfile
			where		objectid in (
							select	data
							from	#application.dbowner#farBlog_aAuthors
							<cfif len(stPost.farBlogID)>
								where	parentid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#stPost.farBlogID#" />
							</cfif>
						)
			order by	lastname,firstname
		</cfquery>
		
		<cfif application.security.checkPermission(permission="farBlogAdmin") or application.fapi.hasRole("sysadmin")>
			<cfset result = "#session.dmProfile.objectid#:#session.dmProfile.firstname# #session.dmProfile.lastname#">
		</cfif>
		
		<cfloop query="qAuthors">
			<cfset result = listappend(result,"#qAuthors.objectid#:#qAuthors.firstname# #qAuthors.lastname#") />
		</cfloop>
		
		<cfreturn result />
	</cffunction>
	
	<cffunction name="getCommentStats" access="public" output="false" returntype="struct" hint="Returns stats about a post's comments">
		<cfargument name="objectid" type="uuid" required="true" hint="The post to query" />
		
		<cfset var stResult = structnew() />
		<cfset var q = "" />
		
		<cfset stResult.total = 0 />
		<cfset stResult.pending = 0 />
		<cfset stResult.approved = 0 />
		
		<cfquery datasource="#application.dsn#" name="q">
			select		bPublish,count(bPublish) as total
			from		#application.dbowner#farBlogComment
			where		parentid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#" />
			group by	bPublish
		</cfquery>
		
		<cfloop query="q">
			<cfif q.bPublish>
				<cfset stResult.approved = q.total />
			<cfelse>
				<cfset stResult.pending = q.total />
			</cfif>
			<cfset stResult.total = stResult.total + q.total />
		</cfloop>
		
		<cfreturn stResult />
	</cffunction>
	
	
	<cffunction name="getComments" access="public" output="false" returntype="query" hint="Returns a query of objectids of all the comments attached to the blogpostid passed in.">
		<cfargument name="objectid" required="true" type="uuID" />
		
		<cfset var qComments = queryNew("") />

		<cfquery datasource="#application.dsn#" name="qComments">
			SELECT objectid
			FROM farBlogComment
			WHERE 
				parentid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#">
				AND bPublish = 1
			ORDER BY datetimecreated
		</cfquery>

		<cfreturn qComments />
	</cffunction>

	<cffunction name="getTotalComments" access="public" output="false" returntype="numeric" hint="Returns the total of all the comments attached to the blogpostid passed in.">
		<cfargument name="objectid" required="true" type="uuID" />
		
		<cfset var qComments = getComments(arguments.objectid) />

		<cfreturn qComments.recordCount />
	</cffunction>

	<cffunction name="getRecentPosts" access="public" output="false" returntype="query" hint="Return a query of recent x blog posts.">
		<cfargument name="maxrows" default="5" type="numeric" />	
		<cfargument name="lCategoryIDs" default="" type="string" />

		<cfset var q = getPostsByCategoryList(lCategoryIDs="#arguments.lCategoryIDs#", maxRows="#arguments.maxRows#") />

		<cfreturn q />
	</cffunction>
	<cffunction name="getMostPopluarPosts" access="public" output="false" returntype="query" hint="Return a query of popular x blog posts.">
		<cfargument name="maxrows" default="5" type="numeric" />
		
		<cfset var q = "" />
		
		<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
			select     	parentID as objectid, COUNT(*) as numComments
			from       	farBlogComment
			group by	parentID
			order by	numComments desc			
		</cfquery>	
		
		<cfreturn q />
	</cffunction>

	<cffunction name="getArchiveLinks" access="public" output="false" returntype="query" hint="Return a query of months that contain blog posts.">

		<cfset var qMonths = queryNew("") />
		
		<cfquery datasource="#application.dsn#" name="qMonths">
			SELECT month(publishDate) as archiveMonth, year(publishDate) as archiveYear
			FROM farBlogPost
			GROUP BY month(publishDate), Year(publishDate), status
			HAVING farBlogPost.status = <cfqueryparam value="approved" cfsqltype="cf_sql_varchar" />
			ORDER BY archiveYear DESC, archiveMonth DESC
		</cfquery>

		<cfreturn qMonths />
	</cffunction>

	<cffunction name="getArchivePosts" access="public" output="false" returntype="query" hint="Return a query of posts for a specified month.">
		<cfargument name="archiveMonth" default="#month(now())#" type="numeric" />	
		<cfargument name="archiveYear" default="#year(now())#" type="numeric" />	
			
		<cfquery datasource="#application.dsn#" name="qArchivePosts">
			SELECT objectid
			FROM farBlogPost
			WHERE 
				month(publishDate) = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.archiveMonth#" />
				AND Year(publishDate) = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.archiveYear#" />
				AND status = <cfqueryparam value="approved" cfsqltype="cf_sql_varchar" />
			ORDER BY publishdate DESC
		</cfquery>

		<cfreturn qArchivePosts />
	</cffunction>

	<cffunction name="getPostsByCategory" access="public" output="false" returntype="query" hint="Return a query of posts in a category.">
		<cfargument name="categoryID" required="true" type="string" />
		<cfargument name="maxrows" default="5" type="numeric" />	

		<cfset var q = getPostsByCategoryList(lCategoryIDs="#arguments.categoryID#",maxrows="#arguments.maxrows#") />

		<cfreturn q />
	</cffunction>

	<cffunction name="getPostsByCategoryList" access="public" output="false" returntype="query" hint="Return a query of posts in a list of categories.">
		<cfargument name="lCategoryIDs" required="true" type="string" />
		<cfargument name="maxrows" default="5" type="numeric" />	

		<cfset var q = queryNew("objectID") />

		<cfquery datasource="#application.dsn#" name="q" maxrows="#arguments.maxrows#">
			SELECT distinct objectID,title,publishDate
			FROM farBlogPost p
			WHERE status = <cfqueryparam value="approved" cfsqltype="cf_sql_varchar" />
			<cfif len(arguments.lCategoryIDs)>
				AND objectid in (
					select distinct objectid 
				    from refCategories 
				    where categoryID IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lCategoryIDs#" list="true" />)
				)
			</cfif>
			ORDER BY publishDate DESC
		</cfquery>

		<cfreturn q />
	</cffunction>

	<cffunction name="getPostCategories" access="public" output="false" returntype="query" hint="Return a query of categories assigned to a blog post.">
		<cfargument name="objectid" required="true" type="string" />

		<cfset var q = queryNew("objectID") />

		<cfquery datasource="#application.dsn#" name="q">
			select distinct r.categoryID,c.categoryLabel
		    from 		refCategories r
		    			inner join
		    			dmCategory c
		    			on r.categoryid=c.objectid
		    where 		r.objectid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#" />
		   	order by	c.categorylabel
		</cfquery>

		<cfreturn q />
	</cffunction>

	<cffunction name="getActiveCategories" access="public" output="false" returntype="query" hint="Return a query of categories assigned to a blog post.">
		
		<cfset var q = queryNew("objectID") />

		<cfquery datasource="#application.dsn#" name="q">
			SELECT c.objectid, c.categoryLabel, COUNT(c.objectid) AS assigned
			FROM dmCategory c 
				INNER JOIN refCategories p 
					INNER JOIN farBlogPost bp
					ON p.objectid = bp.objectid
				ON c.objectid = p.categoryID
			GROUP BY c.objectid, c.categoryLabel,bp.status
			HAVING bp.status = 'approved'
		</cfquery>

		<cfreturn q />
	</cffunction>
	
	<cffunction name="getBlogPostCategories" access="public" returntype="string" output="false" hint="Returns a list of categories for a blog">
		<cfargument name="objectid" required="true" />
		
		<cfset var stBlogPost = getData(arguments.objectid) />
		<cfset var stBlog = "" />
		<cfset var lBlogCategories = "" />
		
		<cfif len(stBlogPost.farBlogID)>
			<cfset stBlog = application.fapi.getContentObject(typename="farBlog", objectid="#stBlogPost.farBlogID#") />
			<cfif listLen(stBlog.lCategories)>
				<cfset lBlogCategories = stBlog.lCategories />
			</cfif>
		</cfif>
		
		<cfreturn lBlogCategories />
	</cffunction>
</cfcomponent>