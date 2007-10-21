<!--------------------------------------------------------------------
dmNews
featured article display method 
--------------------------------------------------------------------->
<!--- @@displayname: Main featured news article --->

<cfoutput>
	<h4><a href="#Application.URL.conjurer#?objectID=#stObj.objectID#">#stObj.title#</a></h4>
	<p>#stObj.teaser#</p>
	<p>Date published: #dateformat(stObj.PUBLISHDATE,'DD/MM/YY')#</p>
</cfoutput>