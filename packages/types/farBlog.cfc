<cfcomponent name="farBlog" extends="farcry.core.packages.types.types" output="false" displayname="Blog" fualias="Blog" description="Blog Management">
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
		fttype="image" ftDestination="/images/blog/teaser" fthint="This is a smaller version of the header image that will appear on teaser views of your blog."/>
		
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
	
</cfcomponent>
