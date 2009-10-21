<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Latest Entries for each Blog --->
<!--- @@description:   --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>


<cfparam name="stParams.lBlogIDs" default="" />

<cfif not listLen(stParams.lBlogIDs)>
	<cfset qAllBlogs =  getAllBlogs()>
	<cfset stParams.lBlogIDs = valueList(qAllBlogs.objectid) />
</cfif>



<cfoutput>
<div class="blog-pod">		
	<h3>Latest Entries</h3>
	<cfloop list="#stParams.lBlogIDs#" index="i">
		<cfset stLocal.stLatestPost = getLatestPost(objectid=i) />
		
		<cfif not structIsEmpty(stLocal.stLatestPost)>
			<skin:view objectid="#stLocal.stLatestPost.objectid#" typename="farBlogPost" webskin="displayTeaserShort" />
		</cfif>
	</cfloop>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false">