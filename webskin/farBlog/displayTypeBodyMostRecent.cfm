<cfsetting enablecfoutputonly="true" /> 
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
<!--- @@displayname: Blog listing with most recent post--->
<!--- @@description:   --->
<!--- @@author: Jason.V (jasonv@daemon.com.au) --->
<!--- import tag libraries --->
<!--- <cfimport taglib="/farcry/core/tags/formtools/" prefix="ft" /> --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin" />

<cfif request.stObj.typename eq "dmInclude">
	<cfoutput>
		<h1>#request.stObj.title#</h1>
	</cfoutput>
<cfelse>
	<cfoutput><h1>Blogs</h1></cfoutput>
</cfif>

<cfset qAllBlogs =  getAllBlogs()>
<cfoutput><div class="blog-list"></cfoutput>

<cfloop query="qAllBlogs">
	<skin:view objectid="#qAllBlogs.objectid#" webskin="displayTeaserMostRecentPost" />
</cfloop>

<cfoutput></div></cfoutput>
<cfsetting enablecfoutputonly="false" /> 