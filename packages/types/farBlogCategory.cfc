<cfcomponent displayname="blogCategory" name="farBlogCategory" extends="farcry.core.packages.types.types">
	
	<cfproperty ftSeq="1" ftFieldSet="General Details" name="title" type="string" required="no" default="" ftLabel="Category" />

	<cffunction name="getCategories" access="public" output="false" returntype="query">
		<cfargument name="blogID" required="false" type="string" />
		<cfargument name="postID" required="false" type="string" />
		
		<cfset var qCategories = queryNew("") />
		
		<cfquery datasource="#application.dsn#" name="qCategories">
			SELECT DISTINCT a.title, a.objectID, b.total
			FROM farBlogCategory a
				INNER JOIN 
				(
					SELECT data, COUNT(data) AS total
					FROM farBlogPost_aCategories
					<cfif isValid("UUID",arguments.postID)>
						WHERE parentID = '#arguments.postID#'
					</cfif>
					GROUP BY data
				) b
				ON a.objectID = b.data				
				INNER JOIN farBlogPost_aCategories d
				ON a.objectID = d.data
				INNER JOIN farBlogPost c
				ON c.objectID = d.parentID
			WHERE
				1 = 1
				<cfif isValid("UUID",arguments.postID)>
					AND d.parentID = '#arguments.postID#' 
				</cfif>
				<cfif isValid("UUID",arguments.blogID)>
					AND c.farBlogID = '#arguments.blogID#'
				</cfif>
			ORDER BY a.title ASC
		</cfquery>
		
		<cfreturn qCategories />
	</cffunction>
	
</cfcomponent>
