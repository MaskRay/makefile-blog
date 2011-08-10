<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
<head>
   <meta http-equiv="content-type" content="text/html; charset=utf-8" />
   <title>MaskRay</title>
   <meta name="author" content="MaskRay" />
    
   <!--google font api-->
   <link href='http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:regular,bold' rel='stylesheet' type='text/css'>

   <!--blue print CSS-->
   <link rel="stylesheet" href="/css/blueprint/screen.css" type="text/css" media="screen, projection">
   <link rel="stylesheet" href="/css/blueprint/print.css" type="text/css" media="print">

   <!-- syntax highlighting CSS -->
   <link rel="stylesheet" href="/css/syntax.css" type="text/css" />

   <!-- Homepage CSS -->
   <link rel="stylesheet" href="/css/override.css" type="text/css" media="all" />
   <link rel='stylesheet' href='/css/board.css' type='text/css' />
   <!-- Typekit -->
   <!--<script type="text/javascript" src="http://use.typekit.com/jpd0pfm.js"></script>-->
   <!--<script type="text/javascript">try{Typekit.load();}catch(e){}</script>-->
   <script type="text/javascript">
     function replace_content_by_id(id,content) {
       xmlhttp=new XMLHttpRequest();
       xmlhttp.open("GET",content,false);
       xmlhttp.send();
       document.getElementById(id).innerHTML = xmlhttp.responseText;
     }
   </script>
</head>
<body>
    <div id='header'>
        <div class="span-18 site">
            <h1 id="site_title"><a href="/">MaskRay</a></h1>
        </div>
    </div>
    <div id="contain">
        <div id='mainNav'>
            <!--<ul>
                <li><a href='/'>Home</a></li>
            </ul>
            <br />
            <p>Categories</p>-->
            <ul>
                
changequote({,})
define(LI,{<li><a href="javascript:replace_content_by_id('content','tags/$1.html')">$1</a></li>})
changequote()
