<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>_TITLE()</title>
    <meta name="author" content="MaskRay" />
    
    <!-- openid -->
    <link rel="openid.server" href="https://login.launchpad.net/+openid" />
    <link rel="openid.delegate" href="https://login.launchpad.net/+id/63hThQp" />
    <link rel="openid2.provider" href="https://login.launchpad.net/+openid" />
    <link rel="openid2.local_id" href="https://login.launchpad.net/+id/63hThQp" />
    <meta http-equiv="X-XRDS-Location" content="https://login.launchpad.net/+id/63hThQp/+xrds" />
    <!--google font api-->
    <link href='http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:regular,bold' rel='stylesheet' type='text/css' />

    <!--blue print CSS-->
    <link rel="stylesheet" href="/css/blueprint/screen.css" type="text/css" media="screen, projection" />
    <link rel="stylesheet" href="/css/blueprint/print.css" type="text/css" media="print" />

    <!-- syntax highlighting CSS -->
    <link rel="stylesheet" href="/css/syntax.css" type="text/css" />

    <!-- Homepage CSS -->
    <link rel="stylesheet" href="/css/override.css" type="text/css" media="all" />
    <link rel='stylesheet' href='/css/board.css' type='text/css' />
    <!-- Typekit -->
    <!--<script type="text/javascript" src="http://use.typekit.com/jpd0pfm.js"></script>-->
    <!--<script type="text/javascript">try{Typekit.load();}catch(e){}</script>-->
  </head>
  <body>
    <div id='header'>
      <div class="span-18 site">
        <h1 id="site_title"><a href="/">MaskRay</a></h1>
      </div>
    </div>
    <div id="contain">
      <div id="containBg">
        <div id="innerPage">
            <div id='mainNav'>
              <ul id="main">
                <li class="widget">
              <div class="widget">
                <h2>Links</h2>
                <ul>
                  <li><a href="http://hsyyf.me/">月下叹逍遥</a></li>
                  <li><a href="http://tusooa.tk/">tusooa</a></li>
                  <li><a href="http://iperl.co.cc/">darkraven</a></li>
		  <li><a href="http://cfy.machinelife.org/">cfy</a></li>
		  <li><a href="http://machinelife.org/">Kandu</a></li>
                  <li><a href="http://forum.ubuntu.org.cn/">笨兔论坛</a></li>
                </ul>
              </div>
                </li>
                <li class="widget">
              <div class="widget">
                  <h2>Tags</h2>
                  m4_include(`layout/tags.m4')
              </div>
                </li>
                <li class="widget">
              <div class="widget">
                <h2>Misc</h2>
                <ul>
                  <li><a href="/atom.xml">RSS</a></li>
                </ul>
              </div>
                </li>
              </ul>
            </div>

            <div id='other'>
              <div class="span-24 last">
                _CONTENT()
              </div>
              <div id="disqus_thread"></div>
              <script type="text/javascript">
                /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
              var disqus_shortname = 'tusooaTk'; // required: replace example with your forum shortname

              // The following are highly recommended additional parameters. Remove the slashes in front to use.
              // var disqus_identifier = 'unique_dynamic_id_1234';
              // var disqus_url = 'http://example.com/permalink-to-page.html';

              /* * * DON'T EDIT BELOW THIS LINE * * */
              (function() {
               var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
               dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
               (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
               })();
             </script>
             <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
             <a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>
           </div>
         </div> <!--#innerPage-->
      </div> <!--#containBg-->
    </div> <!--#contain-->
    <div id="footer">
      <div class="span-24 last">
        <div class="span-12">
          <h2>Network</h2>
          <p>
            <a href="http://twitter.com/Mask_Ray/">My Twitter</a><br />
          </p>
        </div>
      </div>
    </div>
    <!--google analytics-->
    <script type="text/javascript">

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-17606054-1']);
      _gaq.push(['_setDomainName', 'none']);
      _gaq.push(['_setAllowLinker', true]);
      _gaq.push(['_trackPageview']);

      (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>
    <!--disqus comment counter-->
    <script type="text/javascript">
      //<![CDATA[
(function() {
	var links = document.getElementsByTagName('a');
	var query = '?';
	for(var i = 0; i < links.length; i++) {
	if(links[i].href.indexOf('#disqus_thread') >= 0) {
		query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
	}
	}
	document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/maskraysblog/get_num_replies.js' + query + '"></' + 'script>');
})();
//]]>
    </script>
  </body>
</html>
