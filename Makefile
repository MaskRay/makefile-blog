HEADER := header.html
FOOTER := footer.html
MONTHS := $(wildcard 20??/[0-9][0-9])

define create-titles
$1/titles-$2: $1/$2
	$$(foreach i,$$(wildcard $1/$2/*/*.html),(/bin/echo -ne $$i\\t;grep -Po '(?<=<title>)[^<]*(?=</title>)' $$i) >> $$@.$$$$$$$$ && ) \
	sort -r $$@.$$$$$$$$ > $$@ && \
	rm $$@.$$$$$$$$

$1/$2: $(patsubst %.org,%.html,$(wildcard $1/$2/*/*.org))
endef

index.html: $(foreach mm,$(MONTHS),$(subst /,/titles-,$(mm))) $(HEADER) $(FOOTER)
	cat $(HEADER) > $@
	for f in `echo $(filter-out %.html,$^) | xargs -n 1 | sort -r`; do \
		awk -F'\t' '{print "     <li>&raquo; <a href="$$1">"$$2"</a>&nbsp;&nbsp;&nbsp;(<a href=/"$$1"#disqus_thread>comments</a>)</li>"; sub(/\/[^\/]*.html/,"",$$1); print "<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>posted on "$$1"</span></li>"}' $$f >> $@; \
	done
	cat $(FOOTER) >> $@

$(foreach mm,$(MONTHS),$(eval $(call create-titles,$(subst /,,$(dir $(mm))),$(notdir $(mm)))))

%.html: %.org
	emacs -l org-xelatex.el --batch --eval '(progn (setq user-full-name "Ray Song")(setq user-mail-address "emacsray@gmail.com")(find-file "$<")(org-export-as-html 3))'
	title=`grep -Po '(?<=<title>)[^<]*(?=</title>)' $@`; \
	/bin/echo -e "H\ng/<div id=\"postamble\">/.-1r !sed -e \"s/<<<1>>>/$$title/\" -e 's!<<<2>>>!http://maskray.tk/$@!' article_footer.html\nw" | ed -s $@

.PHONY: upload
upload:
	rsync -a --exclude auto * maskray@machinelife.org:/var/www/maskray/
