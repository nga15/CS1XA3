#!/bin/bash
echo "(^o^)/ Welcome to Andy's repo! \(^o^)"
echo "What would you like to do?"
echo "Please enter a number listed next to each option to select your choice."
echo "1- Repo Status"
echo "2- Update Uncommitted Changes"
echo "3- Update TODO List"
echo "4- Error Check for Haskell Files"
echo "5- Description of Each Feature"
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
                	ghc -fno-code "$file" &>> error.log
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
	vim ~/CS1XA3/Assign1/README.txt
	./ProjectAnalyze.sh
elif [ $command -eq 6 ]
then
	git status
        
	git status > changes.log
        echo "Uncommitted Changes have been updated to changes.log."
        echo "Would you like to view the log? (Type Y/N)"
        read choice
        if [ $choice = "Y" ]
        then
                vim changes.log
        fi
        
	grep --exclude="todo.log" -r "#TODO" ~/CS1XA3/ > todo.log
        echo "TODO List has been updated!"
        echo "Would you like to view the log? (Type Y/N)"
        read choice
        if [ $choice = "Y" ]
        then
                vim todo.log
        fi
        
	rm ~/CS1XA3/error.log
        find ~/CS1XA3/ -name "*.hs" -print0 |
                while IFS='' read -r -d $'\0' file
                do
                        ghc -fno-code "$file" &>> error.log
                done
        echo "Errors have been checked for all Haskell Files and placed into error.log."
        echo "Would you like to view the log? (Type Y/N)"
        read choice
        if [ $choice = "Y" ]
        then
                vim error.log
        fi
        
	echo "Would you like to view the Guide? (Type Y/N"
	read choice
	if [ $choice = "Y" ]
	then
		vim ~/CS1XA3/Assign1/README.txt
	fi

	./ProjectAnalyze.sh
elif [ $command -eq 0 ]
then
	echo "Thanks for visiting~!"
else
	echo "Please enter one of the choices(numbers) listed above"
	./ProjectAnalyze.sh
fi
