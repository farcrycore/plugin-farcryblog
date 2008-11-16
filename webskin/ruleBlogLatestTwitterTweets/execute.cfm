<cfsetting enablecfoutputonly="true" />
<!--- @@displayname: Execute (Twitter tweets) --->
<!--- @@Description: Execute webskin for recent Twitter tweets. --->
<!--- @@author: Jeff Coughlin (jeff [at] jeffcoughlin [dot] com) --->

<cfoutput>
<div>
	<h3>Twitter</h3>
	<div id="twitter_div">
		<ul id="twitter_update_list"></ul>
	</div>
	<script type="text/javascript" src="http://twitter.com/javascripts/blogger.js"></script>
	<script type="text/javascript" src="http://twitter.com/statuses/user_timeline/#stObj.accountName#.json?callback=twitterCallback2&amp;count=#stObj.numberOfTweets#"></script>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />