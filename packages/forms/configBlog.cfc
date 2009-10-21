<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog Settings --->
<!--- @@Description: Configuration form component for the FarCry Blog plugin --->
<cfcomponent displayname="Blog Settings" extends="farcry.core.packages.forms.forms" output="false" key="farcryblog"
	hint="Configure NearCry to work just the way you want it to.  Customise the details about your blog, the name of the author and more.">
		
	<cfproperty 
		name="relatedLinks" type="longchar" ftType="textfield" default="" hint="A list of related URLS to your blog"
		ftSeq="14" ftFieldset="Blog Settings" ftLabel="Related Links" 
		fthint="Enter a list of related website links." />
	
</cfcomponent>