m4_include(`m4/foreach.m4')
m4_define(`_ALLTAGS', `all, haskell, makefile, udev, ssh, shell, expect, software, network, regex, ruby, perl, csv, desktop')
m4_define(`_LI', `<a style="font-size: m4_eval(m4_esyscmd(echo $RANDOM)%10+15)px;" href="/tags/$1.html">$1</a>&nbsp;&nbsp; ')
foreach(`x', `_LI(x)', _ALLTAGS())
