<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Show Blog Categories --->
<!--- @@Description: Shows a pod with a list of blog categories that link to the category page. --->
<cfcomponent displayname="Blog Pod: Categories" extends="farcry.core.packages.rules.rules" output="false" bObjectBroker="true" lObjectBrokerWebskins=""
	hint="Shows a pod with a list of blog categories that link to the category page.">
		
	<cfproperty ftseq="1" ftfieldset="Rule Settings" name="catOrder" type="string" hint="Display order of the categories in the pod." fttype="list" ftlist="tree:Category Tree Order,alpha:Alphabetic Order" ftlabel="Category Order"
				 fthint="Choose how would you like the category list in your pod to be ordered." />


</cfcomponent>