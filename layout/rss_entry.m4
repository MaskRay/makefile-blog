 <entry>
  <title type="html"><![CDATA[_TITLE()]]></title>
  <link href="_URI()"/>
  <updated>m4_syscmd(stat -c %y _FILE() | cut -c1-19 | tr ' ' T | tr -d '\n')</updated>

  <id>_URI()</id>
  <content type="html"><![CDATA[m4_undivert(_FILE())]]></content>
 </entry>
