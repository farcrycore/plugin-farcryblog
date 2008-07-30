<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Latest Blog Comments --->
<!--- @@Description: Lists the latest blog comments with links to the blog post --->


<cfcomponent displayname="Blog: Latest Blog Comments" extends="farcry.core.packages.rules.rules" output="false" bObjectBroker="true" lObjectBrokerWebskins=""
	hint="Lists the latest blog comments with links to the blog post">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="Blog Comments" name="numberOfComments" type="integer" required="true" default="10" hint="Number of Comments to list." ftType="integer" ftLabel="Number of Comments" ftDefault="10" />


</cfcomponent>