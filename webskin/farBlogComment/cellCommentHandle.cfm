<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Cell: Name/Description --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfoutput>
<b>#stobj.commentHandle#</b><br />
<cfif len(stobj.email)><a href="mailto:#stobj.email#">#stobj.email#</a><br /></cfif>
#stObj.description#<br />
#stobj.website#
</cfoutput>

<cfsetting enablecfoutputonly="false" />