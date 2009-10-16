<cfcomponent displayname="Blog: List blogs" hint="Displays a listing of all the blogs in the application" extends="farcry.core.packages.rules.rules" output="false">
	<cfproperty ftSeq="1" ftFieldset="Blogs" ftLabel="Blogs" 
		name="aBlogs" type="array" required="true" hint="The blog this post is listed under"
		ftType="array" ftJoin="farBlog" ftRenderType="list" />
	<cfproperty ftseq="2" ftfieldset="Blogs" ftLabel="Display Method"
		name="displayMethod" type="string" default="displayTeaserStandard" hint="Blog Title." ftvalidation="required" required="true"
		fttype="webskin" fttypename="farBlog" ftprefix="displayTeaser" ftHint="This determines how each of your news results will render." />
	
	
</cfcomponent>