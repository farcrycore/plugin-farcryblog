<cfcomponent displayname="blogCategory" name="farBlogCategory" extends="farcry.core.packages.types.types">
	
	<cfproperty ftSeq="1" ftFieldSet="General Details" name="title" type="string" required="no" default="" ftLabel="Category" />

	<cffunction name="getCategories" access="public" output="false" returntype="query">
		<cfargument name="blogID" required="false" type="string" />
		<cfargument name="postID" required="false" type="string" />
		
		<cfset var qCategories = queryNew("") />
		
		<cfquery datasource="#application.dsn#" name="qCategories">
			SELECT DISTINCT a.title, a.objectID, b.total
			FROM farBlogCategory a
				INNER JOIN farBlogPost_aCategories d
				ON a.objectID = d.data
				INNER JOIN farBlogPost c
				ON c.objectID = d.parentID
				INNER JOIN 
				(
					SELECT data, COUNT(data) AS total
					FROM farBlogPost_aCategories 
					WHERE 1 = 1 
					<cfif isValid("UUID",arguments.postID)>
						AND parentID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.postID#" />
					</cfif>
					<cfif isValid("UUID",arguments.blogID)>
						AND parentID IN ( 
							SELECT objectID
							FROM farBlogPost
							WHERE 
								farBlogID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.blogID#" /> AND
								status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#request.lvalidstatus#" />
						)
					</cfif>
					GROUP BY data
				) b
				ON a.objectID = b.data				
			WHERE
				1 = 1
				<cfif isValid("UUID",arguments.postID)>
					AND d.parentID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.postID#" />
				</cfif>
				<cfif isValid("UUID",arguments.blogID)>
					AND c.farBlogID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.blogID#" />
				</cfif>
			ORDER BY a.title ASC
		</cfquery>
		
		<cfreturn qCategories />
	</cffunction>
	
</cfcomponent>
