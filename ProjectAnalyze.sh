#!/bin/bash
echo "Welcome to Andy's repo!"
echo "What would you like to do?"
echo "Please enter a number to select your choice. Press 0 at any time to quit."
echo "1- Repo Status"
echo "2- Update Uncommitted Changes"
echo "3- Update TODO list"
echo "4- Error check for Haskell Files"
echo "5- Description of each feature"
echo "6- Run All"
echo "0- Quit"

read command
if [ $command -eq 1 ]
then
	git status
	./ProjectAnalyze.sh
elif [ $command -eq 2 ]
then
	git status > changes.log
elif [ $command -eq 3 ]
then
	grep -r "#TODO" ~/CS1XA3/ -l > todo.log
elif [ $command -eq 0 ]
then
	echo "Thanks for visiting~!"
fi
#"Got the list of files with TODO, need to iterate through list and print each line throughout"

find ~/CS1XA3/ -name "*.hs" -print
i=0
while [ $i -lt [find ~/CS1XA3/ -name "*.hs" | wc -l ] ]
do
	for a in "find ~/CS1XA3/ -name "*.hs" -print"
	do
		ghc -fno-code "$a.hs"
		echo "It Works???"
	done
	echo "The second works???"
	i = $(($i + 1))
done
#"got the list of .hs files, need to iterate through list and ghc command each file.

 
