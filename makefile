
all:
  mkdir ./public
  echo "test file" > public/test.txt

clean:
  rm -r public
