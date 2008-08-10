<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Standard 2 Column Layout --->
<!--- @@Description: Standard full page display for all content types --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />
<cfimport taglib="/farcry/core/tags/container" prefix="con" />


<!--- Ensure a request.navid exists --->
<cfparam name="request.navid" default="#application.navid.home#" />

<!--- This allows developers to use the standard displayPageStandard layout dynamically swapping the view used in the body section. --->
<cfparam name="url.bodyView" default="displayBody" />


<!--------------
 VIEW
--------------->
<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayHeaderStandard" />


<grid:container id="bd">
	<grid:col span="18">
		<skin:view typename="#stobj.typename#" objectid="#stobj.objectid#" webskin="#url.bodyView#" />

		<con:container label="#stobj.objectID#_Body" defaultMirrorLabel="Body">	
	
	</grid:col>
	<grid:col span="1" />
	<grid:col span="5">
		<con:container label="#stobj.objectID#_Utility" defaultMirrorLabel="Utility">	
	</grid:col>
	
</grid:container>


<skin:view objectID="#stObj.objectID#" typename="#stObj.typename#" webskin="displayFooterStandard" />

<cfsetting enablecfoutputonly="false" />