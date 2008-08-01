<cfsetting enablecfoutputonly="true">
<!--- @@Copyright: Daemon Pty Limited 1995-2007, http://www.daemon.com.au --->
<!--- @@License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php --->
<!--- @@displayname: Category List --->
<!--- @@description: Displays list of Categories assigned to a blog post  --->
<!--- @@author: Matthew Bryant (mbryant@daemon.com.au) --->


<!------------------ 
FARCRY IMPORT FILES
 ------------------>
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<!------------------ 
START WEBSKIN
 ------------------>
<skin:buildLink typename="#stobj.typename#" objectid="#stobj.objectid#" includeDomain="true" r_url="urlPost" />
<cfset urlPost = urlEncodedFormat(urlPost) />
<cfoutput>
<a href="http://digg.com/submit?phase=2&URL=#urlPost#" target="_blank"><img src="http://www.stlaurent-centre.com/email/stl-fathersday/images/digg.gif" alt="Digg this" /></a>
<a href="http://del.icio.us/post?url=#urlPost#" target="_blank"><img src="http://www.stlaurent-centre.com/email/stl-fathersday/images/delicious.gif" alt="Delicious bookmark" /></a>
<a href="http://www.facebook.com/share.php?u=#urlPost#" target="_blank"><img src="http://www.stlaurent-centre.com/email/stl-fathersday/images/facebook.gif" alt="Face book" /></a>
<a href="http://www.stumbleupon.com/submit?url=#urlPost#" target="_blank"><img src="http://www.stlaurent-centre.com/email/stl-fathersday/images/stumble_it.gif" alt="Stumble" /></a>
<a href="http://www.newsvine.com/_tools/seed&save?u=#urlPost#" target="_blank"><img src="http://www.stlaurent-centre.com/email/stl-fathersday/images/seed_newsvine.gif" alt="News-vine" /></a>
</cfoutput>

<cfsetting enablecfoutputonly="false">