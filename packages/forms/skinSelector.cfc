<cfcomponent displayname="Skin Selector" hint="Provides interface and functionality for switching application skin plugin" extends="farcry.core.packages.forms.forms" output="false">
	<cfproperty ftSeq="1" ftFieldset="" name="skin" type="string" default="skinskittlish" hint="The name of the skin plugin" ftLabel="Skin" ftType="list" ftShowLabel="false" ftEditMethod="editSkin" ftAjaxMethod="streamIcon" />
	
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
			<cfoutput></table></cfoutput>
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
		
		<cfset var constructor = "" />
		<cfset var stLoc = structnew() />
		<cfset var oUA = createobject("component",application.stCOAPI.UpdateApp.packagepath) />
		<cfset var stUA = structnew() />
		<cfset var currentSkin = getCurrentSkin() />

		<cffile action="read" file="#application.path.webroot#/farcryConstructor.cfm" variable="constructor" />
		<cfset stLoc = refind("(?:'|""|,)#currentSkin#(?:'|""|,)",constructor,1,true) />
		<cfset constructor = left(constructor,stLoc.pos[1]) & arguments.fields.skin & mid(constructor,stLoc.pos[1]+stLoc.len[1]-1,len(constructor)) />
		<cffile action="write" file="#application.path.webroot#/farcryConstructor.cfm" output="#constructor#" />
		
		<cfset application.bInit = false />
		
		<extjs:bubble message="Skin changed" />
		
		<cfreturn arguments.fields />
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