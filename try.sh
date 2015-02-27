#!/bin/sh
INP=$1
OUP=$2

if [[ "$OUP" == "" || "$INP" == "" ]]; then
  echo "Usage: ./try.sh path/to/input.hs path/to/output.txt"
  exit 1
fi

mkdir -p build
cp $INP build/input.hs
cp lexer build

cd build
java -classpath .. JLex.Main lexer && javac lexer.java && java lexer &&
  (if ! diff -q ../$OUP output.txt; then
    diff -y ../$OUP output.txt | less
  else
    echo "No differences! You're done! Let's party!"
  fi)
