<cfif listLen(stobj.lCategories)>
	<cfoutput>
	<div class="blog-pod">
		<h3>Categories</h3>
		<ul>
			<cfloop list="#stobj.lCategories#" index="i">
				<li>#i#</li>
			</cfloop>
		</ul>
	</div>
	</cfoutput>
</cfif>