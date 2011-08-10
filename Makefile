ECHO := /bin/echo
FOOTER := footer.org
HEADER := header.org
INDEX_HEADER := index_header.org
MONTHS := $(wildcard 20??/[0-9][0-9])

define create-titles
$1/titles-$2: $1/$2
	$(MAKE) $$(foreach h,$$(patsubst %.org,%.html,$$(wildcard $1/$2/*/*.org)),$$h)
	{ $$(foreach i,$$(wildcard $1/$2/*/*.org),$(ECHO) -ne '/$$(patsubst %.org,%.html,$$i) ';$(ECHO) -ne `grep -F '#+TITLE:' $$i | cut -d' ' -f2-;grep -F '#+TAGS:' $$i | cut -d' ' -f2-`;$(ECHO);) } | \
	sort -r  > $$@
endef

.SUFFIXES:
.PHONY: all upload inotify

all: link.html tags/all.html $(patsubst %.m4,%.html,$(wildcard tags/*.m4))

tags/all.m4: $(foreach mm,$(MONTHS),$(subst /,/titles-,$(mm)))
	for f in $?; do \
		for t in tags/*.m4; do \
			cut -d' ' -f1 $$f | grep -vFf /dev/stdin $t > $$t.$$$$; \
			mv $$t.$$$$ $$t; \
		done; \
		awk '{for(i=3;i<=NF;i++){print "LI("$$1","$$2")" >> "tags/"$$i".m4"}}' $$f; \
	done
	for t in tags/*.m4; do \
		sort -r $$t >> $$t.$$$$; \
		mv $$t.$$$$ $$t; \
	done
	for f in `$(ECHO) $^ | xargs -n 1 | sort -r`; do \
		awk '{print "LI("$$1","$$2")"}' $$f; \
	done > $@

tags/%.html: tags_header.m4 tags/%.m4 tags_footer.m4
	m4 $^ > $@

link.html: link.m4
	m4 $< > $@

$(foreach mm,$(MONTHS),$(eval $(call create-titles,$(subst /,,$(dir $(mm))),$(notdir $(mm)))))

%.html: %.org $(FOOTER) $(HEADER)
	emacs -l org-xelatex.el --batch --eval '(progn (find-file "$<") (beginning-of-buffer)(insert-file "$(abspath $(HEADER))") (shell-command-on-region (point-max) (point-max) "[ $@ != index.html ] && sed -e \"s!<<<1>>>!$@!\" -e \"s!<<<2>>>!http://maskray.tk/$@!\" $(abspath $(FOOTER))" (buffer-name) t) (org-export-as-html 3) )'

upload:
	rsync -a --exclude auto * maskray@maskray.tk:/var/www/maskray/

inotify:
	inotifywait -e modify -m -r . --format %w 2>&- | xargs -I % sh -c "touch \`dirname %\`" >&- 2>&- &