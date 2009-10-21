<cfcomponent name="farBlog" extends="farcry.core.packages.types.types" output="false" displayname="Blog" fualias="blog" description="Blog Management">
	<cfproperty ftseq="1" ftwizardstep="General Settings" ftfieldset="Name and Description" ftlabel="Blog Title"
		name="title" type="string" default="" hint="Blog Title." ftvalidation="required" 
		fttype="string" fthint="This is the name of your blog"/>
	<cfproperty ftseq="2" ftwizardstep="General Settings" ftfieldset="Name and Description" ftlabel="Tag Line/Subtitle"
		name="tagline" type="string" default="" hint="" ftvalidation="" 
		fttype="string" fthint="This will appear on your blog header underneath the blog title."/>
	<cfproperty ftseq="3" ftwizardstep="General Settings" ftfieldset="Name and Description" ftlabel="Teaser/Short Description"
		name="teaser" type="longchar" default="" hint="" ftvalidation="" 
		fttype="longchar" fthint="This text will appear on you banner, and on other pages of the site that point to your blog."/>
		
	<cfproperty ftseq="11" ftwizardstep="General Settings" ftfieldset="Banner and Images" ftlabel="Header Image"
		name="headerImage" type="string" default="" hint="" ftvalidation="" 
		fttype="image" ftDestination="/images/blog/header" fthint="This image will appear as the design element in your blog header."/>
	<cfproperty ftseq="12" ftwizardstep="General Settings" ftfieldset="Banner and Images" ftlabel="Blog Teaser Image"
		name="teaserImage" type="string" default="" hint="" ftvalidation="" 
		fttype="image" ftDestination="/images/blog/teaser" ftImageWidth="64" ftImageHeight="64" ftAutoGenerateType="pad" fthint="This is a smaller version of the header image that will appear on teaser views of your blog."/>
		
	<cfproperty ftseq="21" ftwizardstep="General Settings" ftfieldset="Comments" ftlabel="Email Address"
		name="email" type="string" default="" hint="" ftvalidation="" 
		fttype="string" fthint="You will be sent a notification to this email address when comments are made."/>
	<cfproperty ftseq="22" ftwizardstep="General Settings" ftfieldset="Comments" ftlabel="Global Comment Settings"
		name="bEnableComments" type="boolean" default="" hint="" ftvalidation="" 
		fttype="list" ftList="1:Enable comments for the blog by default,0:Disable comments" ftrendertype="radio" fthint="Global comment settings set here can be over ridden for individual blog entries"/>
	<cfproperty ftseq="23" ftwizardstep="General Settings" ftfieldset="Comments" ftlabel="Comment Rules"
		name="bPublishComments" type="boolean" default="" hint="Only used if bEnablecomments is true" ftvalidation="" 
		fttype="list" ftList="1:Publish comments without moderation,0:Comments require moderation" ftrendertype="radio" fthint=""/>
	<cfproperty ftseq="24" ftwizardstep="General Settings" ftfieldset="Comments" ftlabel="Email Notification"
		name="bEmailNotification" type="boolean" default="" hint="Only used if bEnablecomments is true" ftvalidation="" 
		fttype="list" ftList="1:Email me a notification when ever a comment is posted,0:Do not notify me" ftrendertype="radio" fthint=""/>
		
	<cfproperty ftseq="31" ftwizardstep="General Settings" ftfieldset="Authors" ftlabel="Allowed Authors"
		name="aAuthors" type="array" hint="Profiles allowed to create posts to this blog" ftvalidation="" 
		fttype="array" ftJoin="dmProfile" fthint="Select users that can post to this blog" />
	
	
	<cffunction name="getLatestPost" access="public" returntype="struct" output="false" hint="Returns the latest visible blog post, or an empty struct if none exists">
		<cfargument name="objectid" type="uuid" required="true" hint="The blog to query" />
		
		<cfset var qPost = "" />
		
		<cfquery datasource="#application.dsn#" name="qPost" maxrows="1">
			select		objectid
			from		#application.dbowner#farBlogPost
			where		farBlogID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#" />
						and publishDate<<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" />
						and status in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#request.mode.lValidStatus#" />)
			order by	publishdate desc
		</cfquery>
		
		<cfif qPost.recordcount>
			<cfreturn application.fapi.getContentObject(objectid=qPost.objectid,typename="farBlogPost") />
		<cfelse>
			<cfreturn structnew() />
		</cfif>
	</cffunction>
	
	<cffunction name="getLatestPosts" access="public" returntype="query" output="false" hint="Returns the latest [X] blog posts as a query">
		<cfargument name="objectid" type="uuid" required="true" hint="The blog to query" />
		<cfargument name="maxposts" type="numeric" required="false" default="1000" hint="The maximum number of posts to return" />
		
		<cfset var qPost = "" />
		
		<cfquery datasource="#application.dsn#" name="qPost" maxrows="#arguments.maxposts#">
			select		*
			from		#application.dbowner#farBlogPost
			where		farBlogID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#" />
						and publishDate<<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" />
						and status in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#request.mode.lValidStatus#" />)
			order by	publishdate desc
		</cfquery>
		
		<cfreturn qPost />
	</cffunction>
	
	<cffunction name="getBlogsByCurrentUser" access="public" returntype="query" output="false" hint="Returns the blogs the current user can see">
		<cfset var qBlogs = "" />
		
		<cfquery datasource="#application.dsn#" name="qBlogs">
			select		objectid
			from		#application.dbowner#farBlog b
			where		<cfif application.security.checkPermission(permission="farBlogAdmin")>
							objectid in (
								select	parentid
								from	#application.dbowner#farBlog_aAuthors
								where	data=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.dmProfile.objectid#" />
							)
						<cfelse>
							1=1
						</cfif>
			order by	title
		</cfquery>
		
		<cfreturn qBlogs />
	</cffunction>
	
	<cffunction name="getAdminStats" access="public" returntype="struct" output="false" hint="Returns number of posts, pending posts, comments, and pending comments">
		<cfargument name="objectid" type="uuid" required="true" hint="The blog to query" />
		
		<cfset var q = "" />
		<cfset var stResult = structnew() />
		
		<cfquery datasource="#application.dsn#" name="q">
			select		status,count(status) as total
			from		#application.dbowner#farBlogPost
			where		farBlogID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#" />
			group by	status
		</cfquery>
		
		<cfset stResult.all_posts = 0 />
		<cfset stResult.draft_posts = 0 />
		<cfset stResult.pending_posts = 0 />
		<cfset stResult.approved_posts = 0 />
		<cfloop query="q">
			<cfset stResult[q.status & "_posts"] = q.total />
			<cfset stResult["all_posts"] = stResult["all_posts"] + q.total />
		</cfloop>
		
		<cfquery datasource="#application.dsn#" name="q">
			select		c.bPublish,count(bPublish) as total
			from		#application.dbowner#farBlogPost p
						inner join
						#application.dbowner#farBlogComment c
						on p.objectid=c.parentid
			where		p.farBlogID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectid#" />
			group by	bPublish
		</cfquery>
		
		<cfset stResult.all_comments = 0 />
		<cfset stResult.pending_comments = 0 />
		<cfset stResult.approved_comments = 0 />
		<cfloop query="q">
			<cfif q.bPublish eq 1>
				<cfset stResult["approved_comments"] = q.total />
			<cfelse>
				<cfset stResult["pending_comments"] = q.total />
			</cfif>
			<cfset stResult["all_comments"] = stResult["all_comments"] + q.total />
		</cfloop>
		
		<cfreturn stResult />
	</cffunction>
	
	<cffunction name="getBlogs" access="public" returntype="query" output="false" hint="Returns a query of the blogs available in this site">
		<cfset var q = "" />
		
		<cfquery datasource="#application.dsn#" name="q">
			select		objectid,title
			from		#application.dbowner#farBlog
			order by	title
		</cfquery>
		
		<cfreturn q />
	</cffunction>
	
</cfcomponent>
