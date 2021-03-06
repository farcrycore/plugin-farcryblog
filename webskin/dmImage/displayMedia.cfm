<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Display Media --->
<!--- @@description: The default view of this media item.  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
VIEW
------------------->
<cfif len(stObj.standardImage)>
	<cfoutput>
		<img src="#application.url.imageroot##stObj.standardImage#" border="0" alt="#stObj.title#" title="#stObj.title#" />
	</cfoutput>	
</cfif>
<cfsetting enablecfoutputonly="false" />