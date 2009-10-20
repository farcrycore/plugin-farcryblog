<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@License:
    This file is part of FarCry.

    FarCry is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FarCry is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with FarCry.  If not, see <http://www.gnu.org/licenses/>.
--->
<!--- @@displayname: Webtop Overview --->
<!--- @@description: The default webskin to use to render the object's summary in the webtop overview screen  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY INCLUDE FILES
 ------------------>

<!------------------ 
START WEBSKIN
 ------------------>

	<cfset iDeveloperPermission = application.security.checkPermission(permission="developer") />
		
	<cfoutput><img src="#application.url.webtop#/facade/icon.cfm?icon=#application.stCOAPI[stObj.typename].icon#" alt="" class="icon" style="float: right; padding: 10px;" /></cfoutput>
	
	<cfif len(stObj.farBlogID)>
		<cfset stBlog = application.fapi.getContentType(typename="farBlog").getData(objectid=stObj.farBlogID) />
		<cfset stStats = application.fapi.getContentType(typename="farBlog").getAdminStats(objectid=stObj.farBlogID) />
	</cfif>
	
	<cfoutput>
	<dl class="dl-style1" style="padding: 10px;">
		<dt>Blog</dt>
		<dd><cfif len(stObj.farBlogID)>
				#stBlog.title#: 
				<a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogPost.cfm&plugin=farcryblog&farBlogID=#stObj.farBlogID#&status=all">Posts #stStats.all_posts#</a>
				<cfif application.security.checkPermission(permission="farBlogPostApprove")><a href="#application.url.webtop#/admin/customadmin.cfm?module=customlists/farBlogPost.cfm&plugin=farcryblog&farBlogID=#stObj.farBlogID#&status=pending">Posts Awaiting Approval #stStats.pending_posts#</a></cfif>
			<cfelse>
			<em>unknown</em></cfif>
		</dd>
		<dt>#getI18Property("title","label")#</dt>
		<dd><cfif stobj.title NEQ "">
			#stobj.title#<cfelse>
			<i>#application.rb.getResource("coapi.constants.undefined@label","undefined")#</i></cfif>
		</dd>
		<dt>#application.rb.getResource("coapi.labels.contentitemtype@label","Content Item Type")#</dt>
		<dd><cfif structKeyExists(application.types[stobj.typename],"displayname")>
			#application.rb.getResource("coapi.#stobj.typename#.displayname@label",application.types[stobj.typename].displayname)#<cfelse>
			#application.rb.getResource("coapi.#stobj.typename#.displayname@label",stobj.typename)#</cfif>
		</dd>
		<dt>#getI18Property("datetimeCreated","Label")#</dt>
		<dd>#application.thisCalendar.i18nDateFormat(stobj.datetimecreated,session.dmProfile.locale,application.shortF)#</dd>
		<dt>#getI18Property("publishDate","Label")#</dt>
		<dd>#application.thisCalendar.i18nDateFormat(stobj.publishdate,session.dmProfile.locale,application.shortF)#</dd>
		<dt>#application.rb.getResource("workflow.labels.locking@label","Locking")#</dt>
		<dd><cfif stobj.locked and stobj.lockedby eq session.security.userid>
				<!--- locked by current user --->
				<cfset tDT=application.thisCalendar.i18nDateTimeFormat(stobj.dateTimeLastUpdated,session.dmProfile.locale,application.mediumF)>
			<span style="color:red">#application.rb.formatRBString("workflow.labels.lockedwhen@label",tDT,"Locked ({1})")#</span> <a href="navajo/unlock.cfm?objectid=#stobj.objectid#&typename=#stobj.typename#">[#application.rb.getResource("workflow.buttons.unlock@label","Unlock")#]</a>
			<cfelseif stobj.locked>
				<!--- locked by another user --->
				<cfset subS=listToArray('#application.thisCalendar.i18nDateFormat(stobj.dateTimeLastUpdated,session.dmProfile.locale,application.mediumF)#,#stobj.lockedby#')>
			#application.rb.formatRBString('workflow.labels.lockedby@label',subS,'<span style="color:red">Locked ({1})</span> by {2}')#
				<!--- check if current user is a sysadmin so they can unlock --->
				<cfif iDeveloperPermission eq 1><!--- show link to unlock --->
				<a href="navajo/unlock.cfm?objectid=#stobj.objectid#&typename=#stobj.typename#">[#application.rb.getResource("workflow.buttons.unlock@label","Unlock")#]</a>
				</cfif><cfelse><!--- no locking --->
				#application.rb.getResource("workflow.labels.unlocked@unlocked","Unlocked")#</cfif>
		</dd>
		<cfif StructKeyExists(stobj, "datetimelastupdated")>
			<dt>#getI18Property("datetimelastupdated","label")#</dt>
			<dd>#application.thisCalendar.i18nDateFormat(stobj.datetimelastupdated,session.dmProfile.locale,application.mediumF)#</dd>
		</cfif>
		<cfif StructKeyExists(stobj, "lastupdatedby")>
			<dt>#getI18Property("lastUpdatedBy","Label")#</dt>
			<dd>#stobj.lastupdatedby#</dd>
		</cfif>
		<cfif StructKeyExists(stobj, "status")>	
			<dt>#getI18Property("status","label")#</dt>
			<dd>#stobj.status#</dd>
		</cfif>
		<cfif StructKeyExists(stobj, "displaymethod")>		
			<dt>#getI18Property("displaymethod","label")#</dt>
			<dd>#stobj.displaymethod#</dd>
		</cfif>
		<cfif StructKeyExists(stobj, "teaser")>
			<dt>#getI18Property("teaser","label")#</dt>
			<dd>#stobj.teaser#</dd>
		</cfif>
		<cfif StructKeyExists(stobj, "teaserImage") AND stobj.teaserImage NEQ "">
			<dt>#getI18Property("teaserImage","label")#</dt>
			<dd><img src="#stobj.teaserImage#"></dd>
		</cfif>
		<cfif iDeveloperPermission eq 1>
			<dt>ObjectID</dt>
			<dd>#stobj.objectid#</dd>
		</cfif>
		</dl>
	</cfoutput>


<cfsetting enablecfoutputonly="false">