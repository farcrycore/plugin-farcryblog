<cfcomponent displayname="Skin Selector" hint="Provides interface and functionality for switching application skin plugin" extends="farcry.core.packages.forms.forms" output="false">
	<cfproperty ftSeq="1" ftFieldset="" name="skin" type="string" default="skinskittlish" hint="The name of the skin plugin" ftLabel="Skin" ftType="list" ftShowLabel="false" ftEditMethod="editSkin" ftAjaxMethod="streamIcon" />
	<cfproperty ftSeq="2" ftFieldset="" name="bDirectories" type="boolean" default="0" hint="Should www directores be copied and removed on installation / uninstallation?" ftLabel="Copy files to webroot?" ftType="boolean" />
	
	
	<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
	<cfimport taglib="/farcry/core/tags/extjs" prefix="extjs" />
	
	<cffunction name="editSkin" access="public" returntype="string" description="Provides the UI for editing the plugin skin" output="false">
		<cfargument name="typename" required="true" type="string" hint="The name of the type that this field is part of.">
		<cfargument name="stObject" required="true" type="struct" hint="The object of the record that this field is part of.">
		<cfargument name="stMetadata" required="true" type="struct" hint="This is the metadata that is either setup as part of the type.cfc or overridden when calling ft:object by using the stMetadata argument.">
		<cfargument name="fieldname" required="true" type="string" hint="This is the name that will be used for the form field. It includes the prefix that will be used by ft:processform.">
		
		<cfset var html = "" />
		<cfset var lPlugins = getAvailableSkins() />
		<cfset var thisplugin = "" />
		<cfset var oManifest = "" />
		<cfset var index = 0 />
		<cfset var selectedSkin = "" />
		
		<skin:htmlHead><cfoutput>
			<style>
				table.skinteasers, table.skinteasers td {
					border: 0 none;
				}
				
				table.skinteasers tr.alt td {
					background-color: ##eee;
				}
				
				table.skinteasers td.radio {
					vertical-align: middle;
				}
				
				table.skinteasers td.description {
				
				}
				
				table.skinteasers td.screenshot {
					padding: 0;
				}
			</style>
		</cfoutput></skin:htmlHead>
		
		<cfdirectory action="list" directory="#application.path.plugins#" recurse="false" name="qPlugins" />
		
		<cfsavecontent variable="html">
			<cfoutput><table class="skinteasers"></cfoutput>
			<cfloop list="#lPlugins#" index="thisplugin">
				<cfset oManifest = getManifest(thisplugin) />
				<cfif structkeyexists(oManifest,"type") and oManifest.type eq "skin">
					<cfset index = index + 1 />
					<cfif listcontainsnocase(application.plugins,thisplugin)>
						<cfset selectedSkin = thisplugin />
					</cfif>
					<cfoutput>
						<tr class="<cfif index mod 2>alt</cfif>">
							<td class="radio" valign="middle">
								<input type="radio" name="#arguments.fieldname#" value="#thisplugin#"<cfif listcontainsnocase(application.plugins,thisplugin)> checked="true"</cfif> />
							</td>
							<td class="description">
								<h2><cfif structkeyexists(oManifest,"name")>#oManifest.name#<cfelse>#thisplugin#</cfif></h2>
								<cfif structkeyexists(oManifest,"description")><p>#oManifest.description#</p></cfif>
							</td>
							<td class="screenshot">
								<cfif structkeyexists(oManifest,"icon") and len(oManifest.icon)>
									<img src="#application.url.webtop#/facade/ftajax.cfm?formtool=list&typename=skinSelector&property=skin&fieldname=#arguments.fieldname#&plugin=#thisplugin#&icon=#oManifest.icon#" />
								</cfif>
							</td>
						</tr>
					</cfoutput>
				</cfif>
			</cfloop>
			<cfoutput>
					<tr class="<cfif index mod 2>alt</cfif>">
						<td class="radio" valign="middle">
							<input type="radio" name="#arguments.fieldname#" value="none"<cfif not len(selectedSkin)> checked="true"</cfif> />
						</td>
						<td class="description">
							<h2>No Skin</h2>
							<p>Only the default skins provided by the Blog plugin and your project will be used.</p>
						</td>
						<td class="screenshot">
							&nbsp;
						</td>
					</tr>
				</table>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>

	<cffunction name="streamIcon" access="public" returntype="string" description="Serves the skin screenshots" output="false">
		<cfargument name="typename" required="true" type="string" hint="The name of the type that this field is part of.">
		<cfargument name="stMetadata" required="true" type="struct" hint="This is the metadata that is either setup as part of the type.cfc or overridden when calling ft:object by using the stMetadata argument.">
		<cfargument name="fieldname" required="true" type="string" hint="This is the name that will be used for the form field. It includes the prefix that will be used by ft:processform.">
		
		<cfparam name="url.plugin" />
		<cfparam name="url.icon" />
		
		<cfif fileexists("#application.path.plugins#/#url.plugin#/install/#url.icon#")>
			<cfcontent file="#application.path.plugins#/#url.plugin#/install/#url.icon#" />
		</cfif>
		
		<cfreturn "" />
	</cffunction>
	
	<cffunction name="process" access="public" output="false" returntype="struct" hint="Empty process function">
		<cfargument name="fields" type="struct" required="true" hint="The fields submitted" />
		
		<cfset uninstallPlugin(getCurrentSkin(),arguments.fields.bDirectories) />
		<cfif not arguments.fields.skin eq "none">
			<cfset installPlugin(arguments.fields.skin,arguments.fields.bDirectories) />
		</cfif>
		
		<cfreturn arguments.fields />
	</cffunction>

	<cffunction name="uninstallPlugin" access="public" returntype="boolean" description="Attempts to uninstall the specified plugin" output="false">
		<cfargument name="plugin" type="string" required="true" hint="The plugin to remove" />
		<cfargument name="bRemoveDirectory" type="boolean" required="true" default="true" hint="If a webroot directory exists for this plugin should it be removed?" />
		
		<cfset var constructor = "" />
		<cfset var currentplugins = "" />
		<cfset var stLoc = structnew() />
		<cfset var currentSkin = getCurrentSkin() />

		<cfif len(arguments.plugin)>
			
			<cftry>
				<!--- Update constructor --->
				<cffile action="read" file="#application.path.webroot#/farcryConstructor.cfm" variable="constructor" />
				<cfset stLoc = refind("plugins ?= ?(?:'|"")([^'""]*)",constructor,1,true) />
				<cfset currentplugins = mid(constructor,stLoc.pos[2],stLoc.len[2]) />
				<cfset currentplugins = listdeleteat(currentplugins,listfindnocase(currentplugins,arguments.plugin)) />
				<cfset constructor = left(constructor,stLoc.pos[2]-1) & currentplugins & mid(constructor,stLoc.pos[2]+stLoc.len[2],len(constructor)) />
				<cffile action="write" file="#application.path.webroot#/farcryConstructor.cfm" output="#constructor#" />
				
				<!--- Remove skin www directory to webroot --->
				<cfif arguments.bRemoveDirectory and directoryexists("#application.path.webroot#/#arguments.plugin#") and directoryExists("#application.path.plugins#/#arguments.plugin#/www")>
			 		<cfdirectory action="delete" directory="#application.path.webroot#/#arguments.plugin#" recurse="true" />
				</cfif>
				
				<cfset application.bInit = false />
				
				<cfcatch>
					<cfreturn false />
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfreturn true />
	</cffunction>

	<cffunction name="installPlugin" access="public" returntype="boolean" description="Attempts to install the specified plugin" output="false">
		<cfargument name="plugin" type="string" required="true" hint="The plugin to install" />
		<cfargument name="bCreateDirectory" type="boolean" required="true" default="true" hint="If this plugin has a www directory, should it be copied to the webroot" />
		
		<cfset var constructor = "" />
		<cfset var currentplugins = "" />
		<cfset var stLoc = structnew() />
		<cfset var oZip = "" />
		
		<!--- <cftry> --->
			<!--- Update constructor --->
			<cffile action="read" file="#application.path.webroot#/farcryConstructor.cfm" variable="constructor" />
			<cfset stLoc = refind("plugins ?= ?(?:'|"")([^'""]*)",constructor,1,true) />
			<cfset currentplugins = mid(constructor,stLoc.pos[2],stLoc.len[2]) />
			<cfset currentplugins = listappend(currentplugins,arguments.plugin) />
			<cfset constructor = left(constructor,stLoc.pos[2]-1) & currentplugins & mid(constructor,stLoc.pos[2]+stLoc.len[2],len(constructor)) />
			<cffile action="write" file="#application.path.webroot#/farcryConstructor.cfm" output="#constructor#" />
			
			<!--- Copy skin www directory to webroot --->
			<cfif arguments.bCreateDirectory and not directoryexists("#application.path.webroot#/#arguments.plugin#") and directoryExists("#application.path.plugins#/#arguments.plugin#/www")>
		 		<cfif not directoryExists("#application.path.webroot#/#arguments.plugin#")>
					<cfdirectory action="create" directory="#application.path.webroot#/#arguments.plugin#" mode="777" />
				</cfif>
				<cfset oZip = createObject("component", "farcry.core.packages.farcry.zip") />
				<cfset oZip.AddFiles(zipFilePath="#application.path.webroot#/plugin-webroot.zip", directory="#application.path.plugins#/#arguments.plugin#/www", recurse="true", compression=0, savePaths="false") />
				<cfset oZip.Extract(zipFilePath="#application.path.webroot#/plugin-webroot.zip", extractPath="#application.path.webroot#/#arguments.plugin#", overwriteFiles="true") />
				<cffile action="delete" file="#application.path.webroot#/plugin-webroot.zip" />
				<cfset directoryRemoveSVN(source="#application.path.webroot#/#arguments.plugin#") />
			</cfif>
			
			<cfset application.bInit = false />
			
			<!--- <cfcatch>
				<cfreturn false />
			</cfcatch>
		</cftry> --->
	
		<cfreturn true />
	</cffunction>
	
	<cffunction name="directoryRemoveSVN" access="public" returntype="void" description="Remove .svn folders from entire directory" output="true">
		<cfargument name="source" required="true" type="string">
	
		<cfset var contents = querynew("empty") />
			
		<cfdirectory action="list" directory="#arguments.source#" name="contents">
		
		<cfloop query="contents">
			<cfif contents.type eq "dir">
				<cfif contents.name eq ".svn">
					<cfdirectory action="delete" directory="#arguments.source#/#contents.name#" recurse="true" />
				<cfelse>
					<cfset directoryRemoveSVN(arguments.source & "/" & contents.name) />
				</cfif>
				
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="getAvailableSkins" access="public" returntype="string" description="Returns skins available for selection" output="false">
		<cfset var qPlugins = querynew("empty") />
		<cfset var result = "" />
			
		<cfdirectory action="list" directory="#application.path.plugins#" recurse="false" name="qPlugins" />
		
		<cfloop query="qPlugins">
			<cfif qPlugins.type eq "dir" and fileexists("#qPlugins.directory#/#qPlugins.name#/install/manifest.cfc")>
				<cfset oManifest = createobject("component","farcry.plugins.#qPlugins.name#.install.manifest") />
				<cfif structkeyexists(oManifest,"type") and oManifest.type eq "skin">
					<cfset result = listappend(result,qPlugins.name) />
				</cfif>
			</cfif>
		</cfloop>
		
		<cfreturn result />
	</cffunction>
	
	<cffunction name="getManifest" access="public" returntype="any" description="Instantiates and returns the plugin manifest" output="false">
		<cfargument name="plugin" type="string" required="true" hint="Plugin name" />
	
		<cfif fileexists("#application.path.plugins#/#arguments.plugin#/install/manifest.cfc")>
			<cfreturn createobject("component","farcry.plugins.#arguments.plugin#.install.manifest") />
		<cfelse>
			<cfreturn structnew() />
		</cfif>
	</cffunction>

	<cffunction name="getCurrentSkin" access="public" returntype="string" description="Returns the name of the current skin plugin" output="false">
		<cfset var lPlugins = getAvailableSkins() />
		<cfset var thisplugin = "" />
		
		<cfloop list="#lPlugins#" index="thisplugin">
			<cfif listcontainsnocase(application.plugins,thisplugin)>
				<cfreturn thisplugin />
			</cfif>
		</cfloop>
		
		<cfreturn "" />
	</cffunction>

</cfcomponent>