<cfcomponent displayname="Blog: Latest Tweets from Twitter" extends="farcry.core.packages.rules.rules" output="false" bObjectBroker="true" lObjectBrokerWebskins="execute:5"
  hint="Lists the latest tweets from your twitter account with links directly to the tweet. Caches for 5 minutes.">

  <!--- properties --->
  <cfproperty ftSeq="1" ftFieldset="Twitter Info" name="accountName" type="nstring" required="true" default="" hint="Twitter account name" ftType="string" ftLabel="Twitter Account Name" ftDefault="" ftValidation="required" />
  <cfproperty ftSeq="10" ftFieldset="Twitter Info" name="numberOfTweets" type="integer" required="true" default="5" hint="Number of Tweets to list." ftType="integer" ftLabel="Number of Tweets" ftDefault="5" ftValidation="required,validate-digits" />

</cfcomponent>