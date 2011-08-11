m4_define(`foreach',`m4_ifelse(m4_eval($#>2),1,
    `m4_pushdef(`last_$1',m4_eval($#==3))m4_dnl
  `'m4_pushdef(`$1',`$3')$2`'m4_popdef(`$1')m4_dnl
  `'m4_popdef(`last_$1')m4_dnl
  `'m4_ifelse(m4_eval($#>3),1,`$0(`$1',`$2',m4_shift(m4_shift(m4_shift($@))))')')')
