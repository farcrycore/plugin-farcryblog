<cfsetting enablecfoutputonly="true">

<!--- import tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">
<cfimport taglib="/farcry/core/tags/grid" prefix="grid" />
<cfimport taglib="/farcry/plugins/farcryblog/tags" prefix="blog" />

<!--- params --->
<cfparam name="stParam.pageTitle" default="#stobj.label#" type="string" />


<cfoutput>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<cfif structKeyExists(stObj, "extendedMetaData") AND len(trim(stObj.extendedMetaData))><meta name="description" content="#trim(stObj.extendedMetaData)#" /></cfif>
	<cfif structKeyExists(stObj, "metaKeywords") AND len(trim(stObj.metaKeywords))><meta name="keywords" content="#trim(stObj.metaKeywords)#" /></cfif>
	<title><blog:config property="blogTitle" />:  #stParam.pageTitle#</title>

  	<!-- Framework CSS -->
	<link rel="stylesheet" href="#application.url.webroot#/farcryblog/css/blueprint/grid.css" type="text/css" media="screen, projection" />
	<link rel="stylesheet" href="#application.url.webroot#/farcryblog/css/blueprint/print.css" type="text/css" media="print" />
  	<!--[if IE]><link rel="stylesheet" href="#application.url.webroot#/farcryblog/css/blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->	

	<!-- Project CSS -->
	<link rel="stylesheet" href="#application.url.webroot#/farcryblog/css/main.css" type="text/css" media="screen, projection" />
	<link rel="stylesheet" href="#application.url.webroot#/farcryblog/css/print.css" type="text/css" media="print" />

	<script type="text/javascript" src="#application.url.webroot#/farcryblog/js/common.js"></script>
	
</head>
<body>
</cfoutput>

	<grid:container>
		<grid:col id="header" span="24" bLast="true">
		
			<grid:col span="21">
				<grid:col span="15">
					<cfoutput>
						<div id="site-name">#application.config.general.sitetitle#</div>
					</cfoutput>
				</grid:col>
				
				<grid:col span="6" bLast="true" />
				
			
				<grid:col span="21" bLast="true">
					 <skin:genericNav navID="#application.navid.home#"
						id="nav"
						depth="2"
						bActive="true"
						bIncludeHome="true">
				</grid:col>
			</grid:col>

			
			<grid:col span="3" bLast="true">
				<cfoutput>
					<div id="poweredby">
						<a href="http://www.farcrycore.org/">
							<img alt="FarCry - Mollio" src="#application.url.webroot#/wsimages/mollio.gif"/>
						</a>
					</div>
				</cfoutput>
			</grid:col>
		
		</grid:col>
	</grid:container>

<cfsetting enablecfoutputonly="false">