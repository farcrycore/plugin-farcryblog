<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Media --->
<!--- @@description: The default view of this media item.  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>

<cfif len(stobj.flashURL)>
	<skin:flashWrapper swfWidth="#stobj.flashWidth#" swfHeight="#stobj.flashHeight#" swfSource="#stobj.flashURL#" />
<cfelseif len(stobj.flashMovie)>
	<skin:flashWrapper swfWidth="#stobj.flashWidth#" swfHeight="#stobj.flashHeight#" swfSource="#stobj.flashMovie#" />
</cfif>
	
	
<cfsetting enablecfoutputonly="false">