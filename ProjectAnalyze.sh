#!/bin/bash
echo "Hello World"
git status
git status > changes.log

grep -r "#TODO" ~/CS1XA3/ -l > todo.log
#"Got the list of files with TODO, need to iterate through list and print each line throughout"

find ~/CS1XA3/ -name "*.hs" -print
i = 0
while [ $i -lt [find ~/CS1XA3/ -name "*.hs" | wc -l ] ]
do
	for a in find ~/CS1XA3/ -name "*.hs" -print
	do
		ghc -fno-code "$a.hs"
		echo "It Works???"
	done
	echo "The second works???"
	i = $(($i + 1))
done
#"got the list of .hs files, need to iterate through list and ghc command each file.

 
