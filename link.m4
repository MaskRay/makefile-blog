define(`_li',`<li><a href="/tags/$1.html" target="content">$1</a/></li>')
<html>
  <head>
    <!-- <link rel="stylesheet" type="text/css" href="/css/board.css"/> -->
  </head>
  <body>
    <div id="mainNav">
      <ul>
        _li(all)
        _li(ssh)
	_li(expect)
	_li(shell)
      </ul>
    </div>
  </body>
</html>
