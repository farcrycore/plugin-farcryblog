<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display Related Blog Posts --->
<!--- @@description: Displays post that have been attached to this one.  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/formtools" prefix="ft" />
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>
<!--- related blog posts --->
<skin:relatedContent objectID="#stObj.objectID#" typename="farBlogPost" webskin="displayLink" arrayProperty="aRelatedPosts" rendertype="unordered" filter="farBlogPost" r_html="relatedContent" />

<cfif structkeyexists(variables, "relatedContent") AND len(relatedContent)>
	<cfoutput>
	<h3>Related Blog Posts</h3>
	#relatedContent#
	</cfoutput>
</cfif>

<cfsetting enablecfoutputonly="false">