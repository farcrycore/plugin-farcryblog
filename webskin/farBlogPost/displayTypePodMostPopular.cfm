<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Recent Blog Posts --->
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
<cfset stLocal.qPopularPosts = getMostPopluarPosts() />

<cfoutput>
<div class="blog-pod">		
	<h3>Most Popular Blog Posts</h3>
	<ul>
	<cfloop query="stLocal.qPopularPosts">
		<li><skin:view typename="farBlogPost" objectid="#stLocal.qPopularPosts.objectid#" webskin="displayLink" /></li>
	</cfloop>
	</ul>
</div>
</cfoutput>


<cfsetting enablecfoutputonly="false">