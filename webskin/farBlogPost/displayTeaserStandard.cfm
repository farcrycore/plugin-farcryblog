<cfsetting enablecfoutputonly="true" />
<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au $

|| VERSION CONTROL ||
$Header: $
$Author: $
$Date: $
$Name: $
$Revision: $

|| DESCRIPTION || 
$Description: $

|| DEVELOPER ||
$Developer: Geoff Bowers (modius@daemon.com.au)$
--->
<!--- @@displayname: Blog Item  --->
<cfimport prefix="skin" taglib="/farcry/core/tags/webskin">
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />

<!--- hack: to get around recordset rendered webskins having no array data --->
<cfset stMedia=getdata(objectid=stobj.objectid, bArraysAsStructs=true) />

<cfoutput>
<div class="item">
	<div class="date">
		<div>#dateformat(stobj.publishdate, "MMM")#</div>
		<span>#dateformat(stobj.publishdate, "DD")#</span>
	</div>
	<div class="content">
		<h1></cfoutput><skin:buildlink objectid="#stobj.objectid#" linktext="#stObj.Title#" /><cfoutput></h1>
		<div class="body">
			<p>#stObj.Teaser#</p>
			</cfoutput>
			
			<cfif arraylen(stmedia.amedia) AND stmedia.amedia[1].typename eq "dmFlash">
				<ft:object objectid="#stmedia.amedia[1].data#" format="display" r_stfields="stfields" />
				<cfif structkeyexists(stfields, "flashURL")>
					<skin:flashwrapper swfWidth="#stfields.flashwidth.value#" swfHeight="#stfields.flashheight.value#" swfSource="#stfields.flashURL.value#" />
				</cfif>
			<cfelseif arraylen(stmedia.amedia) AND stmedia.amedia[1].typename eq "dmImage">
				<ft:object objectid="#stmedia.amedia[1].data#" format="display" r_stfields="stfields" />
				<cfoutput>#stfields.StandardImage.html#</cfoutput>
			</cfif>
			
			<cfif len(stobj.body)>
				<cfoutput><p></cfoutput><skin:buildlink objectid="#stobj.objectid#" linktext="More on this post..." /><cfoutput></p></cfoutput>
			</cfif>
			
			<skin:view typename="farBlogPost" objectid="#stobj.objectid#" webskin="displayPostFooter" />
			
			<cfoutput>
		</div>
		
	</div>
</div>
</cfoutput>
<cfsetting enablecfoutputonly="false" />
