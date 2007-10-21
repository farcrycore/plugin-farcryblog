<cfcomponent displayname="Blog: Show Posts" extends="farcry.core.packages.rules.rules" 
	hint="Blog Post rule publishes blog posts in date order, with 
		most recently published first.  Blog posts are only visible 
		if it is a) approved content; b) time is past the publish date; 
		c) it matches the nominated categories."
	bObjectBroker="true" 
	lObjectBrokerWebskins="execute">

<cfproperty ftseq="1" ftfieldset="Blog Posts" name="numberofposts" type="numeric" default="10" hint="Number of blog posts to list." fttype="numeric" ftIncludeDecimal="false" ftlabel="Number of Posts" />	
<cfproperty ftseq="2" ftfieldset="Blog Posts" name="catBlogPost" type="string" default="" hint="Categories to filter listing of blog posts." fttype="category" ftlabel="Category Filter" ftalias="farblogpost" />

</cfcomponent>