
RUBY = ruby

BODIES = $(patsubst src/%.md,public/%.html,$(wildcard src/*.md src/**/*.md))

all: $(BODIES) public/style.css

install:
	gem install kramdown

clean:
	rm -r public || true
	rm -r tmp || true

public/%.html: tmp/%.md
	mkdir -p $(dir $@)
	$(RUBY) make-html.rb $< > $@

tmp/%.md: src/%.md
	mkdir -p $(dir $@)
	cp $< $@

public/style.css: style.css
	cp $< $@