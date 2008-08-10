<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: ruleBlogArchivePod Display Body --->
<!--- @@Description: Default farcryblog body display. --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- required attributes --->
<cfparam name="stparam.qArchiveLinks" type="query" />

<cfoutput>
<div>
	<h3>Archive</h3>
	<ul>
	<cfloop query="stparam.qArchiveLinks">
	  <li><skin:buildlink type="farBlogPost" view="displayPageStandard" urlParameters="bodyView=displayBodyArchive&amp;archiveMonth=#stparam.qArchiveLinks.archiveMonth#&amp;archiveYear=#stparam.qArchiveLinks.archiveYear#" linktext="#monthAsString(stparam.qArchiveLinks.archiveMonth)# #stparam.qArchiveLinks.archiveYear#" /></li>
	</cfloop>
	</ul>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />