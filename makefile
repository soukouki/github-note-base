
all:
	mkdir ./public || echo public exists
	echo "<h1>test</h1>" > public/index.html

clean:
	rm -r public
