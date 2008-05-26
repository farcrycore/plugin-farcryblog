<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display post teaser --->
<!--- @@Description: Standard teaser for blog posts --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!--- hack: to get around recordset rendered webskins having no array data --->
<cfset stMedia = getData(objectID=stObj.objectID, bArraysAsStructs=true) />

<cfoutput>
<div class="item">
	<div class="date">
		<div>#dateformat(stObj.publishDate, "MMM")#</div>
		<span>#dateformat(stObj.publishDate, "DD")#</span>
	</div>
	<div class="content">
		<h1></cfoutput><skin:buildlink objectID="#stObj.objectID#" linktext="#stObj.title#" /><cfoutput></h1>
		<div class="body">
			<p>#stObj.teaser#</p>
			</cfoutput>

			<cfif arraylen(stMedia.aMedia) AND stMedia.aMedia[1].typename eq "dmFlash">
				<ft:object objectID="#stMedia.aMedia[1].data#" format="display" r_stfields="stFields" />
				<cfif structkeyexists(stFields, "flashURL")>
					<skin:flashWrapper swfWidth="#stFields.flashwidth.value#" swfHeight="#stFields.flashheight.value#" swfSource="#stFields.flashURL.value#" />
				</cfif>
			<cfelseif arraylen(stMedia.aMedia) AND stMedia.aMedia[1].typename eq "dmImage">
				<ft:object objectID="#stMedia.aMedia[1].data#" format="display" r_stFields="stFields" />
				<cfoutput>#stFields.standardImage.html#</cfoutput>
			</cfif>

			<cfif len(stObj.body)>
				<cfoutput><p></cfoutput><skin:buildlink objectID="#stObj.objectID#" linktext="More on this post..." /><cfoutput></p></cfoutput>
			</cfif>

			<skin:view objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayPostFooter" />

			<cfoutput>
		</div>

	</div>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />