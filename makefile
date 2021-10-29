
all:
	mkdir ./public || echo public exists
	echo "test file" > public/test.txt

clean:
	rm -r public
