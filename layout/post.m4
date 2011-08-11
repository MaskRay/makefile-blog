m4_include(`m4/foreach.m4')
m4_changecom()
<div id="post">
    <h2>_TITLE()</h2>
    _POST()
</div>
<br />
<p>
m4_define(`_LI', `<a href="/tags/$1.html">$1</a>&nbsp;')
foreach(`x', `_LI(x)', _TAGS())
</p>
<br />
<!--
<div id="disqus_thread"></div>
<script type="text/javascript">
    var disqus_title = "{{ page.title }}";
    var disqus_url = "http://roylez.heroku.com{{ page.url }}";
//<![CDATA[
    var disqus_developer = location.host.match(/\.dev$|^localhost/) ? 1 : 0;
//]]>
</script>
<script src="http://disqus.com/forums/tusooa/embed.js" type="text/javascript"></script>
<noscript><a href="http://tusooa.disqus.com/?url=ref">View the discussion thread.</a></noscript>
-->
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
