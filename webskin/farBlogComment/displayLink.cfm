<cfsetting enablecfoutputonly="true" />

<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Display post title/link with author --->
<!--- @@Description: Display subject and link for a blog comment content item in the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<skin:view typename="farBlogComment" objectid="#stobj.objectid#" webskin="displayCommentHandle" r_html="htmlCommentHandle" />

<cfoutput>#htmlCommentHandle# on <skin:buildlink objectID="#stObj.parentID#" linktext="#stObj.label#" /></cfoutput>

<cfsetting enablecfoutputonly="false" />