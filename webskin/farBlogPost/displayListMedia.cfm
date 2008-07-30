<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Display list of inline media --->
<!--- @@Description:  --->

<!--- import tag libraries --->
<cfimport prefix="ft" taglib="/farcry/core/tags/formtools" />
<cfimport prefix="skin" taglib="/farcry/core/tags/webskin" />

<cfif arrayLen(stobj.aMedia)>

	<cfloop from="1" to="#arrayLen(stobj.aMedia)#" index="i">
		<skin:view objectID="#stobj.aMedia[i]#" webskin="displaySnag" />
	</cfloop>

</cfif>


<cfsetting enablecfoutputonly="false" />