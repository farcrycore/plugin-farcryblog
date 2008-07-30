<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Execution of ruleBlogArchivePod --->
<!--- @@Description:  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />


<cfset qArchiveLinks = createObject("component", application.stcoapi["farBlogPost"].packagePath).getArchiveLinks() />
<cfoutput>
<div>
	<h3>Archive</h3>
	<ul>
	<cfloop query="qArchiveLinks">
	  <li><skin:buildlink type="farBlogPost" view="displayPageStandard" urlParameters="bodyView=displayBodyArchive&archiveMonth=#qArchiveLinks.archiveMonth#&archiveYear=#qArchiveLinks.archiveYear#" linktext="#monthAsString(qArchiveLinks.archiveMonth)# #qArchiveLinks.archiveYear#" /></li>
	</cfloop>
	</ul>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false" />