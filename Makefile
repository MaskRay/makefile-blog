ECHO := /bin/echo
HEADER := header.html
FOOTER := footer.html
ARTICLE_FOOTER := article_footer.html
MONTHS := $(wildcard 20??/[0-9][0-9])

define create-titles
$1/titles-$2: $1/$2
	$(MAKE) $$(foreach h,$$(patsubst %.org,%.html,$$(wildcard $1/$2/*/*.org)),$$h)
	{ $$(foreach i,$$(wildcard $1/$2/*/*.html),$(ECHO) -ne $$i\\t;grep -Po '(?<=<title>)[^<]*(?=</title>)' $$i;) } | \
	sort -r  > $$@
endef

index.html: $(foreach mm,$(MONTHS),$(subst /,/titles-,$(mm))) $(HEADER) $(FOOTER)
	{ cat $(HEADER) && \
	for f in `$(ECHO) $(filter-out %.html,$^) | xargs -n 1 | sort -r`; do \
		awk -F'\t' '{print "     <li>&raquo; <a href="$$1">"$$2"</a>&nbsp;&nbsp;&nbsp;(<a href=/"$$1"#disqus_thread>comments</a>)</li>"; sub(/\/[^\/]*.html/,"",$$1); print "<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>posted on "$$1"</span></li>"}' $$f; done; \
	cat $(FOOTER); } > $@

$(foreach mm,$(MONTHS),$(eval $(call create-titles,$(subst /,,$(dir $(mm))),$(notdir $(mm)))))

%.html: %.org $(ARTICLE_FOOTER)
	emacs -l org-xelatex.el --batch --eval '(progn (setq user-full-name "Ray Song")(setq user-mail-address "emacsray@gmail.com")(find-file "$<")(org-export-as-html 3))'
	$(ECHO) -e "H\ng/<div id=\"postamble\">/.-1r !sed -e \"s!<<<1>>>!$@!\" -e 's!<<<2>>>!http://maskray.tk/$@!' $(ARTICLE_FOOTER)\nw" | ed -s $@

.PHONY: upload inotify
upload:
	rsync -a --exclude auto * maskray@maskray.tk:/var/www/maskray/

inotify:
	{ inotifywait -e modify -m -r . --format %w | xargs -I % sh -c "touch \`dirname %\`"; } &
