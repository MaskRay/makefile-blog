ECHO := /bin/echo
MONTHS := $(wildcard 20??/[0-9][0-9])

TAG_POSTS := layout/tag_posts.m4
DEFAULT := layout/default.m4
POST := layout/post.m4
TAGS := layout/tags.m4
LINKS := layout/links.m4

SRCS = $(wildcard $(foreach s,org mdown,$1/$2/*/*.$s))
HTML = $(addsuffix .html,$(basename $1))
HTMLS = $(call HTML,$(call SRCS,$1,$2))

define create-titles
$1/titles-$2: $1/$2
	$(MAKE) $$(foreach h,$$(call HTMLS,$1,$2),$$h)
	{ $$(foreach i,$$(call SRCS,$1,$2),$(ECHO) -ne '/$$(call HTML,$$i) ';$(ECHO) -ne `grep -F '#+TITLE:' $$i | cut -d' ' -f2-;grep -F '#+TAGS:' $$i | cut -d' ' -f2-`;$(ECHO);) } | \
	sort -r  > $$@
endef

.SUFFIXES:
.PHONY: all upload inotify

all: index.html

$(foreach mm,$(MONTHS),$(eval $(call create-titles,$(subst /,,$(dir $(mm))),$(notdir $(mm)))))

$(DEFAULT): $(TAGS) $(LINKS)
	touch $@

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
	$(MAKE) tags/*.html

tags/%.html: tags/%.m4 $(DEFAULT) $(TAG_POSTS)
	m4 -P -D_TAG=$* -D_POSTS='m4_include($<)' $(TAG_POSTS) > /tmp/temp
	m4 -P -D_TITLE=MaskRay -D_CONTENT='m4_undivert(/tmp/temp)' $(DEFAULT) > $@

index.html: | tags/all.html
	ln -sf tags/all.html $@

%.html:: %.mdown $(DEFAULT) $(POST)
	TAGS=`grep '#+TAGS:' $< | cut -d' ' -f2- | tr ' ' ,`; \
	TITLE=`grep '#+TITLE:' $< | cut -d' ' -f2`; \
	m4 -P -D_DATE=`echo $@ | awk '{print substr($$0,1,10)}'`  -D_TAGS="$$TAGS" -D_TITLE="$$TITLE" -D_POST='m4_syscmd(grep -v ^# $< | markdown /dev/stdin)' $(POST) > /tmp/temp
	m4 -P -D_TITLE="$$TITLE" -D_CONTENT='m4_undivert(/tmp/temp)' $(DEFAULT) > $@

%.html:: %.org $(DEFAULT) $(POST)
	emacs --batch --eval '(progn (find-file "$<") (org-export-as-html 3) )'
	sed -n '/<body>/,/<\/body>/p' $@ | tail -n +3 | sed '$$d' | sed '$$d' > /tmp/temp
	TAGS=`grep '#+TAGS:' $< | cut -d' ' -f2- | tr ' ' ,`; \
	TITLE=`grep '#+TITLE:' $< | cut -d' ' -f2`; \
	m4 -P -D_TAGS="$$TAGS" -D_TITLE="$$TITLE" -D_POST='m4_undivert(/tmp/temp)' $(POST) > /tmp/temp2
	m4 -P -D_TITLE="$$TITLE" -D_CONTENT='m4_undivert(/tmp/temp2)' $(DEFAULT) > $@

upload:
	rsync -a --delete --exclude auto * maskray@maskray.tk:/var/www/maskray/

clean:
	find 20?? \( -name '*~' -o -name '*#' \) -exec rm {} \;

distclean: clean
	$(RM) index.html
	find 20?? -name '*.html' -exec rm {} \;

inotify:
	inotifywait -e modify -m -r . --format %w 2>&- | xargs -I % sh -c "touch \`dirname %\`" >&- 2>&- &
