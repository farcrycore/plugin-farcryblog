<cfsetting enablecfoutputonly="true" />
<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Comment form --->
<!--- @@Description: User-side comment form --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<!--- import tag libraries --->
<cfimport prefix="ft" taglib="/farcry/core/tags/formtools" />
<cfimport prefix="skin" taglib="/farcry/core/tags/webskin" />
<cfimport prefix="extjs" taglib="/farcry/core/tags/extjs" />


<cfif not len(stObj.parentID)>
	<cfabort showerror="This comment does not have a blog post id set. It has been incorrectly called." />
</cfif>


<!-------------------------------
ACTION:
-------------------------------->
<!--- PERFORM SERVER SIDE VALIDATION --->
<ft:serverSideValidation />

<skin:buildlink objectID="#stObj.parentID#" r_url="returnURL" />

<cfif returnURL contains "?">
	<cfset returnURL = "#returnURL#&commentAdded=true" />
<cfelse>
	<cfset returnURL = "#returnURL#?commentAdded=true" />
</cfif>
	
<ft:processForm action="Post Comment" url="#returnURL#">
	<!--- process action items --->
	<ft:processFormObjects objectid="#stobj.objectid#" r_stProperties="stProps">
		<cfset stPost = createObject("component",application.stCoapi["farBlogPost"].packagePath).getData(objectID=stObj.parentID) />
		<cfif NOT stPost.bAutoPublish>
			<cfset stProps.bPublish = 0 />
		</cfif>
		<!--- validate weblink --->
		<cfif len(trim(stProps.website)) AND left(stProps.website,4) NEQ "http">
			<cfset stProps.website = "http://#trim(stProps.website)#" />
		</cfif>
	</ft:processFormObjects>
</ft:processForm>


<!-------------------------------
VIEW:
-------------------------------->
<cfif NOT structkeyexists(url, "commentAdded")>

	<ft:form>
		<ft:object stObject="#stObj#" lExcludeFields="label,parentID,profileID,bPublish" format="edit" legend="Make a Comment" helptext="HTML not allowed.  Links will be automatically activated." />
		<ft:farcryButtonPanel>
			<ft:button value="Post Comment" bSpamProtect="true" />
		</ft:farcryButtonPanel>
	</ft:form>

<cfelse>

	<extjs:bubble title="Your comment has been added.">
		<cfoutput>Thank you for your comment.</cfoutput>
	</extjs:bubble>


</cfif>

<cfsetting enablecfoutputonly="false" />