<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@displayname: Execution of ruleBlogArchivePod --->
<!--- @@Description:  --->

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<!--- grab archive links --->
<cfset qArchiveLinks = createObject("component", application.stcoapi["farBlogPost"].packagePath).getArchiveLinks() />

<skin:view objectid="#stobj.objectid#" typename="ruleBlogArchivePod" webskin="displayBody" qArchiveLinks="#qArchiveLinks#" />


<cfsetting enablecfoutputonly="false" />