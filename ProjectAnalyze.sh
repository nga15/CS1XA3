#!/bin/bash
# Andy Ng - Feb 26/18
# Main Menu - Greetings and List of choices shown repeatedly for the user to interact with
echo "(^o^)/ Welcome to Andy's repo! \(^o^)"
echo "What would you like to do?"
echo "Please enter a number listed next to each option to select your choice."
echo "1- Repo Status"
echo "2- Update Uncommitted Changes"
echo "3- Update TODO List"
echo "4- Error Check for Haskell Files"
echo "5- Search Using a Keyword"
echo "6- Description of Each Feature"
echo "7- Run All"
echo "0- Exit"

read command									# Takes the input(number) to confirm user's choice
if [ $command -eq 1 ]								# When input is 1 - Repo Status
then
	git status								# Prints out results from git status 
	./ProjectAnalyze.sh							# Runs the script from beginning again

elif [ $command -eq 2 ]								# When input is 2 - Update Uncommitted Changes
then
	git status > changes.log						# Writes results from git status into changes.log 
	echo "Uncommitted Changes have been updated to changes.log."		
	echo "Would you like to view the log? (Type Y/N)"			# Asks user if they would like to view the log
	read choice								# Receives choice
	if [ $choice = "Y" ]
        then
                vim changes.log							# Opens log using vim when user enters "Y" as their choice
	fi
	./ProjectAnalyze.sh

elif [ $command -eq 3 ]								# When input is 3 - Update TODO List
then
	grep --exclude="todo.log" -r "#TODO" ~/CS1XA3/ > todo.log		# Finds all files in the repo with the tag "#TODO" and places it in the todo.log file
	echo "TODO List has been updated!"					# Excluding todo.log 
	echo "Would you like to view the log? (Type Y/N)"			# Asks user if they would like to view the log
	read choice								# Receives choice
	if [ $choice = "Y" ]
	then
		vim todo.log							# Opens log using vim when user enters "Y" as their choice
	fi
	./ProjectAnalyze.sh
elif [ $command -eq 4 ]								# When input is 4 - Error Check for Haskell Files
then
	rm ~/CS1XA3/error.log							# Removes the current error.log file
	find ~/CS1XA3/ -name "*.hs" -print0 |					# Finds every hs file in the repo
        	while IFS='' read -r -d $'\0' file				# Goes through each file
        	do
                	ghc -fno-code "$file" &>> error.log			# Appends both the stdOut and stdErr from the function checking for syntax errors into the 
        	done								# error.log file. As we are not overwriting as before, previous copy must be deleted
	echo "Errors have been checked for all Haskell Files and placed into error.log."
	echo "Would you like to view the log? (Type Y/N)"
	read choice								# Receives user's choice for whether to view the log
	if [ $choice = "Y" ]
	then
		vim error.lo							# Opens log using vim when user enters "Y" as their choiceg
	fi	 
	./ProjectAnalyze.sh
elif [ $command -eq 5 ]								# When input is 5 - Search Using a Keyword
then
	echo "What would you like to search for? Enter your Search Option below: (Press Enter to skip)"
	read search								# Receives the user's search (if any, skips when search is null or just spaces)
	if [ "$search" !=  "" ]							# When input is received (Just spaces are not included)
	then	
		grep --exclude="results.log" -r "$search" ~/CS1XA3/ > results.log
		vim results.log							# Overwrites results.log with search results
	fi									# Skips the search if there is no input or the input are just spaces
	./ProjectAnalyze.sh
elif [ $command -eq 6 ]								# When input is 6 - Description of Each Feature
then
	vim ~/CS1XA3/Assign1/README.txt						# Opens README.txt from the Assign1 directory to display descriptions of functions
	./ProjectAnalyze.sh
elif [ $command -eq 7 ]								# When input is 7 - Run All
then
	git status								# Code from 1st Choice - Repo Status
        
	git status > changes.log						# Code from 2nd Choice - Update Uncommitted Changes
        echo "Uncommitted Changes have been updated to changes.log."
        echo "Would you like to view the log? (Type Y/N)"
        read choice
        if [ $choice = "Y" ]
        then
                vim changes.log
        fi
        
	grep --exclude="todo.log" -r "#TODO" ~/CS1XA3/ > todo.log		# Code from 3rd Choice - Update TODO List
        echo "TODO List has been updated!"
        echo "Would you like to view the log? (Type Y/N)"
        read choice
        if [ $choice = "Y" ]
        then
                vim todo.log
        fi
        
	rm ~/CS1XA3/error.log							# Code from 4th Choice - Error Check for Haskell Files
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
        
	echo "Would you like to search for anything? Enter your Search Option below: (Press Enter to skip)"
        read search								# Code from 5th Choice - Search Using a Keyword
	if [ "$search" != "" ]
	then
        	grep --exclude="results.log" -r "$search" ~/CS1XA3/ > results.log
        	vim results.log
	fi
	
	echo "Would you like to view the Guide? (Type Y/N)"			# Code from 6th Choice - Description of Each Feature
	read choice
	if [ $choice = "Y" ]
	then
		vim ~/CS1XA3/Assign1/README.txt
	fi

	./ProjectAnalyze.sh
elif [ $command -eq 0 ]								# When input is 0
then
	echo "Thanks for visiting~! \(^o^)/"					# Greetings
else
	echo "Please enter one of the choices(numbers) listed above."		# Asks User to reenter if they enter something that doesn't satify list of choices
	./ProjectAnalyze.sh							
fi
