<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Comment Handle --->
<!--- @@description: Displays the comment handle with a link to the website if it exists  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>

<cfif NOT len(stObj.commentHandle)>
	<cfset stObj.commentHandle = "Secret Admirer" />
</cfif>
<cfif len(stObj.website)>
	<cfset stObj.commentHandle = '<a href="#stObj.website#" target="_blank">#stObj.commentHandle#</a>' />
</cfif>

<cfoutput>#stObj.commentHandle#</cfoutput>

<cfsetting enablecfoutputonly="false">
