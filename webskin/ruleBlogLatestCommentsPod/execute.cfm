<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Execute of ruleBlogLatestCommentsPod--->
<!--- @@Description: Default farcryblog execute webskin for ruleBlogLatestCommentsPod. --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- grab recent blog comments --->
<cfset qRecentComments = createObject("component", application.stcoapi["farBlogComment"].packagePath).getRecentComments(maxRows="#stobj.numberOfComments#") />

<skin:view objectid="#stobj.objectid#" typename="ruleBlogLatestCommentsPod" webskin="displayBody" qRecentComments="#qRecentComments#" />

<cfsetting enablecfoutputonly="false" />