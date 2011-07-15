ECHO := /bin/echo
FOOTER := footer.org
HEADER := header.org
INDEX_HEADER := index_header.org
MONTHS := $(wildcard 20??/[0-9][0-9])

define create-titles
$1/titles-$2: $1/$2
	$(MAKE) $$(foreach h,$$(patsubst %.org,%.html,$$(wildcard $1/$2/*/*.org)),$$h)
	{ $$(foreach i,$$(wildcard $1/$2/*/*.html),$(ECHO) -ne $$i\\t;grep -Po '(?<=<title>)[^<]*(?=</title>)' $$i;) } | \
	sort -r  > $$@
endef

index.html:

index.org: $(foreach mm,$(MONTHS),$(subst /,/titles-,$(mm))) $(INDEX_HEADER)
	{ cat $(INDEX_HEADER); \
	for f in `$(ECHO) $(filter-out %.org,$^) | xargs -n 1 | sort -r`; do \
		awk -F'\t' '{print "\n- [[./"$$1"]["$$2"]]"; sub(/\/[^\/]*.html/,"",$$1); print "\n  posted on "$$1}' $$f; \
	done; } > $@

$(foreach mm,$(MONTHS),$(eval $(call create-titles,$(subst /,,$(dir $(mm))),$(notdir $(mm)))))

%.html: %.org $(FOOTER) $(HEADER)
	emacs -l org-xelatex.el --batch --eval '(progn (find-file "$<") (beginning-of-buffer)(insert-file "$(abspath $(HEADER))") (shell-command-on-region (point-max) (point-max) "[ $@ != index.html ] && sed -e \"s!<<<1>>>!$@!\" -e \"s!<<<2>>>!http://maskray.tk/$@!\" $(abspath $(FOOTER))" (buffer-name) t) (org-export-as-html 3) )'

.PHONY: upload inotify
upload:
	rsync -a --exclude auto * maskray@maskray.tk:/var/www/maskray/

inotify:
	{ inotifywait -e modify -m -r . --format %w | xargs -I % sh -c "touch \`dirname %\`"; } &
