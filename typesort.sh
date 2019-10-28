#!/bin/bash
#A shell script with in- and output
#Lars
#28.10.2019
VERSION="1.0"

usage() {
	cat <<EOF
	$thiscommand [ OPTIONS ] FILE [ FILE . . . ]
	Sort filenames by file type as given by
	the ''file'' command
	$thiscommand --version	Print Version number
	OPTIONS :
	-t		sort text files only
	-n		sort non-text files only
	-r		reverse sort order
	-v --verbose	print debugging messages   
    
EOF
}

sortText() {
	if [ "$reverse" == "true" ] ; 
		then file $* | grep ':.*text' | sort -rk2
	 else
	 	file $* | grep ':.*text' | sort -k 2
	fi
}


sortFiles() {
    file $* | sort -k2 
}

# ###########################################################
#			main
# check for options
## note the blanks after ‘[’ and before ‘]’

text=false
nonText=false
reverse=false
verbose=false

while [[ $1 == -* ]]
do
	case $1 in
		"-h" | "--help")
			usage
			exit 0
			;;

		"--version")
			echo "Version: $VERSION"
			exit 0
			;;

		"-t")
			text=true
			;;

		"-n")
			nonText=true
			;;

		"-r")
			reverse=true
			;;

		"-v")
			verbose=true
			echo "text = $text, nonText = $nonText, reverse = $reverse, verbose = $verbose"
			;;


		*)
		echo "try again :)"
	esac
	shift
done

if [ "$text" == "true" ] ;
	then sortText $*
fi

if [ "$nonText" == "true" ] ;
	then sortFiles $*
fi

exit 0
