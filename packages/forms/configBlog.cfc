<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog Settings --->
<!--- @@Description: Configuration form component for the FarCry Blog plugin --->
<cfcomponent displayname="Blog Settings" extends="farcry.core.packages.forms.forms" output="false" key="farcryblog"
	hint="Configure NearCry to work just the way you want it to.  Customise the details about your blog, the name of the author and more.">
		
	<cfproperty 
		name="wddxRelatedLinks" type="longchar" ftType="textfield" default="" hint="A list of related URLS to your blog"
		ftSeq="14" ftFieldset="Blog Settings" ftLabel="Related Sites" 
		fthint="Enter a list of related website links." />


	<!--- Custom property handlers --->
	<cffunction name="ftEditWDDXRelatedLinks" access="public" output="false" returntype="string" hint="his will return a string of formatted HTML text to enable the user to edit the data">
		<cfargument name="typename" required="true" type="string" hint="The name of the type that this field is part of.">
		<cfargument name="stObject" required="true" type="struct" hint="The object of the record that this field is part of.">
		<cfargument name="stMetadata" required="true" type="struct" hint="This is the metadata that is either setup as part of the type.cfc or overridden when calling ft:object by using the stMetadata argument.">
		<cfargument name="fieldname" required="true" type="string" hint="This is the name that will be used for the form field. It includes the prefix that will be used by ft:processform.">
		
		<cfset var html = "" />
		<cfset var aLinks = arraynew(1) />
		<cfset var i = 0 />
		
		<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />
		
		<cfif len(arguments.stMetadata.value) and iswddx(arguments.stMetadata.value)>
			<cfwddx action="wddx2cfml" input="#arguments.stMetadata.value#" output="aLinks" />
		</cfif>
		
		<skin:htmlHead library="jqueryjs" />
		<skin:htmlHead><cfoutput>
			<script type="text/javascript">
				function addLinkItem(id,label,url){
					var jLen = jQ("##"+id+"length");
					var jAddLink = jQ("##"+id+"addlinks");
					
					jLen.val(parseInt(jLen.val())+1);
					
					jAddLink.before("<tr id='"+id+"link"+jLen.val()+"' class='relatedlink'><td><input type='text' name='"+id+"label"+jLen.val()+"' id='"+id+"label"+jLen.val()+"' value='"+label+"' /></td><td><input type='text' name='"+id+"url"+jLen.val()+"' id='"+id+"url"+jLen.val()+"' value='"+url+"' /></td><td style='text-align:right;'><a href='##' class='removelink' title='Remove' onclick='jQ(this).parents(\"tr.relatedlink\").remove();return false;'><img src='#application.url.webtop#/facade/icon.cfm?icon=delete&size=16' alt='Remove' /></a></td></tr>");
				};
			</script>
		</cfoutput></skin:htmlHead>
		
		<cfsavecontent variable="html">
			<cfoutput>
				<input type="hidden" name="#arguments.fieldname#" value=" " />
				<input type="hidden" name="#arguments.fieldname#length" id="#arguments.fieldname#length" value="#arraylen(aLinks)#" />
				<table id="#arguments.fieldname#links" class="relatedlinks" style="width:99%;">
					<tr>
						<th>Label</th>
						<th>URL</th>
						<th>&nbsp;</th>
					</tr>
					<cfloop from="1" to="#arraylen(aLinks)#" index="i">
						<tr id='#arguments.fieldname#link#i#' class='relatedlink'>
							<td><input type='text' name='#arguments.fieldname#label#i#' id='#arguments.fieldname#label#i#' value='#aLinks[i].label#' /></td>
							<td><input type='text' name='#arguments.fieldname#url#i#' id='#arguments.fieldname#url#i#' value='#aLinks[i].url#' /></td>
							<td style='text-align:right;'>
								<a href='##' class='removelink' title='Remove' onclick='jQ(this).parents("tr.relatedlink").remove();return false;'>
									<img src='#application.url.webtop#/facade/icon.cfm?icon=delete&size=16' alt='Remove' />
								</a>
							</td>
						</tr>
					</cfloop>
					<tr id="#arguments.fieldname#addlinks" class="relatedlink">
						<td><a href="##" class="addlink" onclick='addLinkItem("#arguments.fieldname#","","");return false;'><span>add link</span></a></td>
						<td></td>
						<td style="text-align:right;"><a href='##' class='addlink' title='Add' onclick='addLinkItem("#arguments.fieldname#","","");return false;'><img src='#application.url.webtop#/facade/icon.cfm?icon=add&size=16' alt='Add' /></a></td>
					</tr>
				</table>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="ftValidateWDDXRelatedLinks" access="public" output="true" returntype="struct" hint="This will return a struct with bSuccess and stError">
		<cfargument name="stFieldPost" required="true" type="struct" hint="The fields that are relevent to this field type.">
		<cfargument name="stMetadata" required="true" type="struct" hint="This is the metadata that is either setup as part of the type.cfc or overridden when calling ft:object by using the stMetadata argument.">
		
		<cfset var stResult = structnew() />
		<cfset var aLinks = arraynew(1) />
		<cfset var i = 0 />
		<cfset var stLink = structnew() />
		
		<cfset stResult.bSuccess = true>
		<cfset stResult.value = "">
		<cfset stResult.stError = StructNew()>
		
		<cfif structkeyexists(arguments.stFieldPost.stSupporting,"length")>
			<cfloop from="1" to="#arguments.stFieldPost.stSupporting.length#" index="i">
				<cfif structkeyexists(arguments.stFieldPost.stSupporting,"label#i#") and len(arguments.stFieldPost.stSupporting["label#i#"]) and
					  structkeyexists(arguments.stFieldPost.stSupporting,"url#i#") and len(arguments.stFieldPost.stSupporting["url#i#"])>
					<cfset stLink = structnew() />
					<cfset stLink.label = arguments.stFieldPost.stSupporting["label#i#"] />
					<cfset stLink.url = arguments.stFieldPost.stSupporting["url#i#"] />
					<cfset arrayappend(aLinks,stLink) />
				</cfif>
			</cfloop>
			
			<cfwddx action="cfml2wddx" input="#aLinks#" output="stResult.value" />
		</cfif>
		
		<cfreturn stResult />
	</cffunction>

		
</cfcomponent>