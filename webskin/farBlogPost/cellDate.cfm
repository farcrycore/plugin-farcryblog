<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Date admin cell --->

<cfswitch expression="#stObj.status#">
	<cfcase value="draft">
		<cfoutput>Last modified #dateformat(stObj.datetimelastupdated,"d-mm-yy")#</cfoutput>
	</cfcase>
	<cfcase value="pending">
		<cfoutput>Created #dateformat(stObj.datetimecreated,"d-mm-yy")#</cfoutput>
	</cfcase>
	<cfcase value="approved">
		<cfoutput>Published #dateformat(stObj.publishDate,"d-mm-yy")#</cfoutput>
	</cfcase>
</cfswitch>

<cfsetting enablecfoutputonly="false" />