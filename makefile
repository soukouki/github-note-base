
RUBY = ruby

SOURCES = $(wildcard src/*.md src/**/*.md)

BODIES = $(patsubst src/%.md,public/%.html,$(SOURCES))

INDEXES = $(subst //,/,$(patsubst src/%,public/%/index.html,$(sort $(dir $(SOURCES)))))

.PRECIOUS : %.md

all: $(BODIES) $(INDEXES) public/style.css

install:
	gem install kramdown

clean:
	rm -r public || true
	rm -r tmp || true

public/%.html: tmp/%.md
	mkdir -p $(dir $@)
	$(RUBY) make-html.rb $< > $@ 

tmp/index.md: tmp/index.yaml
	$(RUBY) make-index.rb . > $@

tmp/%/index.md: tmp/index.yaml
	$(RUBY) make-index.rb $* > $@

tmp/index.yaml: $(SOURCES)
	$(RUBY) index-sources.rb

tmp/%.md: src/%.md
	mkdir -p $(dir $@)
	cp $< $@

public/style.css: style.css
	cp $< $@
