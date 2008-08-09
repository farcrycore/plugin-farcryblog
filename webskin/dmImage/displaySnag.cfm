<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Display Snag --->
<!--- @@description: Displays image media as a snag.  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
VIEW
------------------->
<cfoutput>
<div class="image-caption">
	<skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayMedia" />
	<p>#stObj.alt#</p>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />