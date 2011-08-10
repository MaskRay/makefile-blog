define(`_li',`<li><a href="/tags/$1.html" target="content">$1</a/></li>')
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/css/font-lock.css" />
  </head>
  <body>
    <div class="content">
      <h1 class="title">MaskRay</h1>
      <div class="header">
        <div class="headerbox"><a href="/tags/all.html" target="content">Home</a></div>
	<br />
        <div class="headerbox"><a href="/sitemap.html" target="content">Sitemap</a></div>
	<br />
        <div class="headerbox"><a href="/about.html" target="content">About</a></div>
      </div>
    </div>
    <div id="mainNav">
      <ul>
        _li(all)
        _li(ssh)
        _li(expect)
        _li(shell)
        _li(software)
        _li(network)
      </ul>
    </div>
  </body>
</html>
