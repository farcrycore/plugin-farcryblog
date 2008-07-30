<!--- @@Copyright: Daemon Pty Limited 1995-2008, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Blog Settings --->
<!--- @@Description: Configuration form component for the FarCry Blog plugin --->
<!--- @@Developer: Ezra Parker (ezra@cfgrok.com) --->

<cfcomponent displayname="Blog Settings" extends="farcry.core.packages.forms.forms" output="false" key="farcryblog"
	hint="Configuration form/data for the FarCry Blog plugin">

<!--- properties --->
<cfproperty ftSeq="1" ftFieldset="Author Info" name="authorName" type="string" required="true" default="Geoff Bowers" hint="Name of the blog author" ftLabel="Author Name" ftDefault="Geoff Bowers" ftValidation="required" />
<cfproperty ftSeq="2" ftFieldset="Author Info" name="authorEmail" type="string" required="true" default="modius@daemon.com.au" hint="Email address of the blog author" ftLabel="Author Email" ftDefault="modius@daemon.com.au" ftValidation="required,validate-email" />

<cfproperty ftSeq="10" ftFieldset="Blog Settings" name="blogTitle" type="string" required="true" default="Daemonite blog" hint="Title of the blog" ftLabel="Blog Title" ftDefault="Daemonite blog" ftValidation="required" />

</cfcomponent>