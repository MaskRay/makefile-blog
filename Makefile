SHELL := /bin/bash
ECHO := /bin/echo
MONTHS := $(wildcard 20??/[0-9][0-9])

TAG_POSTS := layout/tag_posts.m4
DEFAULT := layout/default.m4
POST := layout/post.m4
TAGS := layout/alltags.m4
LINKS := layout/links.m4

RSS_HEAD := layout/rss_head.m4
RSS_ENTRY := layout/rss_entry.m4
RSS_FOOT := layout/rss_foot.m4

SRCS = $(wildcard $(foreach s,org mdown,$1/*/*.$s))
HTML = $(addsuffix .html,$(basename $1))
HTMLS = $(call HTML,$(call SRCS,$1))

.SUFFIXES:
.PRECIOUS: %.phtml
.PHONY: all upload inotify

all: index.html $(call HTML,$(wildcard tags/*.m4)) $(foreach m,$(MONTHS),$(call HTMLS,$m))

index.html: | tags/all.html
	ln -sf tags/all.html $@

tags/%.html: tags/%.m4 $(DEFAULT) $(TAG_POSTS)
	m4 -P -D_TAG=$* -D_POSTS='m4_include($<)' $(TAG_POSTS) > /tmp/temp
	m4 -P -D_TAGS=$* -D_TITLE=MaskRay -D_CONTENT='m4_undivert(/tmp/temp)' $(DEFAULT) > $@

tags/%.m4: tags/all.m4
	sort -r $@ > /tmp/temp && mv /tmp/temp $@

tags/all.m4: $(foreach m,$(MONTHS),$(call SRCS,$m))
	$(RM) tags/*.m4
	m4 -D_TIME=`date +%Y-%m-%dT%H-%M-%S+0800` $(RSS_HEAD) > atom.xml;
	cnt=0; echo $^ | xargs -n1 | sort -r | while read f; do \
		title=`grep '^#.\?TITLE:' $$f | cut -d' ' -f2-`; \
		tags=(all `grep '^#.\?TAGS:' $${f/%.phtml/.*} | cut -d' ' -f2-`); \
		for t in $${tags[@]}; do \
			echo "LI(/$${f/%.*/.html},$$title)" >> tags/$$t.m4; \
		done; \
		if ((++cnt < 10)); then \
			m4 -P -D_TITLE="$$title" -D_URI=http://maskray.tk/$$f -D_FILE=$${f/%.*/.phtml} $(RSS_ENTRY) >> atom.xml; \
		fi; \
	done;
	m4 $(RSS_FOOT) >> atom.xml

%.phtml:: %.mdown
	grep -v '^#' $< | markdown /dev/stdin > $@

%.phtml:: %.org
	emacs --batch --eval '(progn (find-file "$<") (org-export-as-html 3 nil nil nil t) )'
	tail -n +3 $(@:.phtml=.html) > $@

%.html: %.phtml $(DEFAULT) $(POST)
	f=$<; \
	TAGS=`grep '^#.\?TAGS:' $${f/%.phtml/.*} | cut -d' ' -f2- | tr ' ' ,`; \
	TITLE=`grep '^#.\?TITLE:' $${f/%.phtml/.*} | cut -d' ' -f2-`; \
	m4 -P -D_DATE=$${f:0:10} -D_TAGS="$$TAGS" -D_TITLE="$$TITLE" -D_POST='m4_undivert($<)' $(POST) > /tmp/temp; \
	m4 -P -D_TAGS="$$TITLE, $$TAGS" -D_TITLE="$$TITLE" -D_CONTENT='m4_undivert(/tmp/temp)' $(DEFAULT) > $@

$(DEFAULT): $(TAGS) $(LINKS)
	touch $@

upload:
	rsync -a --delete --exclude auto * maskray@maskray.tk:/var/www/maskray/

clean:
	find 20?? \( -name '*~' -o -name '*#' \) -exec rm {} \;

distclean: clean
	$(RM) index.html
	find 20?? -name '*.html' -exec rm {} \;
