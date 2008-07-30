<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Latest Blog Posts --->
<!--- @@Description: Lists the latest blog posts with links --->


<cfcomponent displayname="Blog: Latest Blog Posts Pod" extends="farcry.core.packages.rules.rules" output="false" bObjectBroker="true" lObjectBrokerWebskins=""
	hint="Displays a pod with the latest blog posts with links">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="Blog Posts" name="numberOfPosts" type="integer" required="true" default="10" hint="Number of blog posts to list." ftType="integer" ftLabel="Number of Posts" ftDefault="10" />


</cfcomponent>