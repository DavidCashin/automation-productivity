#!/bin/bash

#Usage:
#	GenerateWebFiles.sh [extension] [FileName] [options]
#	
#	Extensions should not contain a leading period. 
#		-html
#			generate an html5 document	
#	
#	FileName should obey the rules of the operating system.
#
#	Options describe libraries, headers, etc to include for the filetype.
#		-ng
#			generates AngularJS script calling the framework, as well as some directive tags
#		-bootstrap
#			generates a script tag calling the bootstrap library

EXTENSION="$1"
FILENAME="$2"
NUMARGS="$#"
ARGS=("$@")

HTMLBASE="<!doctype html>\n\n<html lang="en">\n\t<head>\n\t\t<title>Title Here</title>\n\t</head>\n\n\t<body>\n\t\t\n\t</body>\n</html>"

if [ "$NUMARGS" -gt 0 ]
then
	# Houston, we have arguments

	if [ "$EXTENSION" = "html" ]
	then
		#Case of no options, just a blank html doc
		echo "Writing HTML"
		echo -e "$HTMLBASE" > "$FILENAME.$EXTENSION"
		
		#Loop through options starting at ARGS[2] adding features as we go
		for (( i=2;i<${#ARGS[@]};i++)); do
			if [ "${ARGS[${i}]}" = "ng" ]
			then
				echo "adding ng framework"	

				NGURL="<script src=\"https:\/\/ajax.googleapis.com\/ajax\/libs\/angularjs\/1.5.2\/angular.min.js\"><\/script>\n\t\t<title>"
				
				perl -p -i -e "s/<title>/$NGURL/" "$FILENAME.$EXTENSION"

			elif [ "${ARGS[${i}]}" = "bootstrap" ]
			then
				echo "adding boostrap library"
				
				NGURL="<link rel=\"stylesheet\" href=\"https:\/\/maxcdn.bootstrapcdn.com\/bootstrap\/3.3.6\/css\/bootstrap.min.css\" integrity=\"sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7\" crossorigin=\"anonymous\">\n\t\t<title>"

				perl -p -i -e "s/<title>/$NGURL/" "$FILENAME.$EXTENSION"
			fi
		done 
		
	else 
		echo "No knowledge of this extension"
	fi
fi