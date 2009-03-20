<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Latest Blog Posts --->
<!--- @@description:   --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->

<!---============================================---
--              Import Tag Libraries              --
---=============================================--->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!---============================================---
--                  Start Webskin                 --
---=============================================--->
<cfset qRecentPosts = getRecentPosts(maxRows="-1") />
<cfset recordsPerPage = 20 />
<cfset numberOfPageLinks = 10 />

<cfif qRecentPosts.recordCount>
  <cfif qRecentPosts.recordCount gt recordsPerPage>
    <skin:pagination qRecordSet="#qRecentPosts#" recordsPerPage="#recordsPerPage#" pageLinks="#numberOfPageLinks#">
      <skin:view typename="farBlogPost" objectid="#stObject.objectid#" template="displayTeaserStandard" alternateHTML="No display template found." />
    </skin:pagination>
  <cfelse>
    <cfloop query="qRecentPosts">
      <skin:view typename="farBlogPost" objectid="#qRecentPosts.objectid#" template="displayTeaserStandard" alternateHTML="No display template found." />
    </cfloop>
  </cfif>
</cfif>

<cfsetting enablecfoutputonly="false">