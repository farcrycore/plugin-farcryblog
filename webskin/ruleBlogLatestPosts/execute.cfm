<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog: Execute Post Rule --->
<!--- @@Description: Execute webskin for ruleBlogPost, a paginated display of post teasers in reverse order of publication date. --->

<!---============================================---
--              Import Tag Libraries              --
---=============================================--->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!---============================================---
--                  Start Webskin                 --
---=============================================--->
<cfset oBlog = createObject("component", application.stcoapi["farBlogPost"].packagePath) />
<cfset qRecentPosts = oBlog.getPostsByCategoryList(lCategoryIDs="#stObj.catBlogPost#", maxRows="-1") />
<cfset recordsPerPage = stObj.numberOfPosts />
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

<cfsetting enablecfoutputonly="false" />