<cfsetting enablecfoutputonly="yes">
<!--- 
|| LEGAL ||
$Copyright: Daemon Pty Limited 1995-2006, http://www.daemon.com.au $
$License: Released Under the "Common Public License 1.0", http://www.opensource.org/licenses/cpl.php$

|| VERSION CONTROL ||
$Header: /home/cvsuser/cvs/daemonite/webskin/includes/dmHeader.cfm,v 1.2 2006/01/19 21:19:20 geoff Exp $
$Author: geoff $
$Date: 2006/01/19 21:19:20 $
$Name: HEAD $
$Revision: 1.2 $

|| DESCRIPTION || 
$Description: $

|| DEVELOPER ||
$Developer: Geoff Bowers (modius@daemon.com.au)$
--->
<cfparam name="attributes.layoutClass" default="typeA">

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin">

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
	<meta name="description" content="description"/>
	<meta name="keywords" content="keywords"/> 
	<meta name="author" content="author"/>
	<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="http://blog.daemon.com.au/xml/rss20.xml" />
	<link rel="stylesheet" type="text/css" href="/css/bittersweet.css" media="screen"/>
	<link type="text/css" rel="stylesheet" href="/js/dp.SyntaxHighlighter/Styles/SyntaxHighlighter.css"></link>
	<script language="JavaScript" type="text/javascript" src="#application.url.farcry#/js/swfObject.js"></script>
	<!--- comment bubbles --->
	<link rel="stylesheet" href="/css/bubbles.css" type="text/css" media="screen" charset="utf-8" />
	<title>Daemonite: team daemon blog</title>
</head>

<body>
<div class="container">

	<div class="top">
		<a href="/"><span>daemonite: blowing the trumpet</span></a>
	</div>
	<div class="header"></div>

	<div class="main">
</cfoutput>
<cfsetting enablecfoutputonly="no">