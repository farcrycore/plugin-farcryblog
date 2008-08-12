<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@displayname: Blog Settings --->
<!--- @@Description: Configuration form component for the FarCry Blog plugin --->
<cfcomponent displayname="Blog Settings" extends="farcry.core.packages.forms.forms" output="false" key="farcryblog"
	hint="Configure NearCry to work just the way you want it to.  Customise the details about your blog, the name of the author and more.">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="Author Info" name="authorName" type="string" required="true" default="Geoff Bowers" hint="Name of the blog author" ftLabel="Author Name" ftDefault="Geoff Bowers" ftValidation="required" />
<cfproperty ftSeq="2" ftFieldset="Author Info" name="authorEmail" type="string" required="true" default="modius@daemon.com.au" hint="Email address of the blog author" ftLabel="Author Email" ftDefault="modius@daemon.com.au" ftValidation="required,validate-email" />

<cfproperty ftSeq="10" ftFieldset="Blog Settings" name="blogTitle" type="string" required="true" default="Daemonite blog" hint="Title of the blog" ftLabel="Blog Title" ftDefault="Daemonite blog" ftValidation="required" />
<cfproperty ftSeq="11" ftFieldset="Blog Settings" name="blogAbout" type="longchar" ftType="richtext" default="" hint="html to appear in the 'about this blog pod'" ftLabel="About this Blog" ftDefault="The ramblings of a FarCry closet freak." />
<cfproperty ftSeq="12" ftFieldset="Blog Settings" name="blogFooterHTML" type="longchar" ftType="richtext" default="" hint="html to appear in the footer" ftLabel="Blog Footer HTML" ftDefault="<p>Valid <a href='http://validator.w3.org/check/referer'>XHTML</a> and <a href='http://jigsaw.w3.org/css-validator/check/referer'>CSS</a>.</p>Any views and opinions expressed herein are those of the author(s) only. All trademarks, slogans, text or logo represented, used, or referred to in this site are the property of their respective owners." />

<cfproperty ftSeq="12" ftFieldset="Blog Settings" name="blogLastMinute" type="longchar" ftType="textfield" default="" hint="Javascript to appear before closing body." ftLabel="Last Minute Javascript" fthint="Ideal for things like Google Analytics tracking codes." />

</cfcomponent>