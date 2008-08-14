<cfsilent>
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Render Config Property --->
<!--- @@description: Templating tag to output blog config property.  --->

<!--- run once only --->
<cfif thisTag.executionMode EQ "end">
	<cfexit method="exittag" />
</cfif>

<!--- required attributes --->
<cfparam name="attributes.property" type="string" />

<cfif structKeyExists(application.config.farcryblog, attributes.property) AND len(application.config.farcryblog[attributes.property])>
	<cfsavecontent variable="content">
	<cfoutput>#application.config.farcryblog[attributes.property]#</cfoutput>
	</cfsavecontent>
<cfelse>
	<cfexit method="exittag" />
</cfif>
</cfsilent>
<cfoutput>#trim(content)#</cfoutput>