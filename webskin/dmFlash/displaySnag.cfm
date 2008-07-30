<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@displayname: Display Snag --->
<!--- @@description: Displays flash media as a snag.  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>

<cfoutput>
<div class="image-caption">
	<skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="displayMedia" />
	<p>#stObj.title#</p>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false">