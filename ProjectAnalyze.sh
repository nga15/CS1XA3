#!/bin/bash
echo "Welcome to Andy's repo!"
echo "What would you like to do?"
echo "Please enter a number to select your choice. Press 0 at any time to exit."
echo "1- Repo Status"
echo "2- Update Uncommitted Changes"
echo "3- Update TODO list"
echo "4- Error check for Haskell Files"
echo "5- Description of each feature"
echo "6- Run All"
echo "0- Exit"

read command
if [ $command -eq 1 ]
then
	git status	
	./ProjectAnalyze.sh
elif [ $command -eq 2 ]
then
	git status > changes.log
	echo "Uncommitted Changes have been updated to changes.log."
	echo "Would you like to view the log? (Type Y/N)"
	read choice
	if [ $choice = "Y" ]
        then
                vim changes.log
	fi
	./ProjectAnalyze.sh
elif [ $command -eq 3 ]
then
	grep --exclude="todo.log" -r "#TODO" ~/CS1XA3/ > todo.log
	echo "TODO List has been updated!"
	echo "Would you like to view the log? (Type Y/N)"
	read choice
	if [ $choice = "Y" ]
	then
		vim todo.log
	fi
	./ProjectAnalyze.sh
elif [ $command -eq 4 ]
then
	rm ~/CS1XA3/error.log
	find ~/CS1XA3/ -name "*.hs" -print0 |
        	while IFS='' read -r -d $'\0' file
        	do
                	ghc -fno-code "$file" >> error.log
        	done
	echo "Errors have been checked for all Haskell Files and placed into error.log."
	echo "Would you like to view the log? (Type Y/N)"
	read choice
	if [ $choice = "Y" ]
	then
		vim error.log
	fi	 
	./ProjectAnalyze.sh
elif [ $command -eq 5 ]
then
	echo "dX"
elif [ $command -eq 6 ]
then
	echo "do everything here"
elif [ $command -eq 0 ]
then
	echo "Thanks for visiting~!"
else
	echo "Please enter one of the choices(numbers) listed above"
	./ProjectAnalyze.sh
fi
