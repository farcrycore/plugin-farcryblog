<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Blog: Show Posts Rule --->
<!--- @@Description: Blog posts rule component for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<cfcomponent displayname="Blog: Show Posts Rule" extends="farcry.core.packages.rules.rules" output="false" bObjectBroker="true" lObjectBrokerWebskins=""
	hint="Blog Post rule publishes blog posts in date order, with
		most recently published first.  Blog posts are only visible
		if it is a) approved content; b) time is past the publish date;
		c) it matches the nominated categories.">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="Blog Posts" name="numberOfPosts" type="integer" required="true" default="10" hint="Number of blog posts to list." ftType="integer" ftLabel="Number of Posts" ftDefault="10" />
<cfproperty ftSeq="2" ftFieldset="Blog Posts" name="aCategories" type="array" required="false" default="" hint="Blog categories used to filter listing of blog posts." ftType="array" ftJoin="farBlogCategory" ftLabel="Blog Category" />
<cfproperty name="lCategories" type="longchar" required="false" default="" hint="List of blog categories from category array" ftType="arrayList" ftArrayField="aCategories" />



</cfcomponent>