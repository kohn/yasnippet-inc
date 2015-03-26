# yasnippet-inc
Help to insert header file automatically when expand yasnippet template. Buffer will be checked to avoid duplicated insertion of header file. The only requirement is that you have to write your first header file manully, otherwise this plugin doesn't know where is the header file area.


# Install
Copy content in yasnippet-inc.el to your .emacs file. Reopen emacs.

# Usage
Update or create new yasnippet, and add header file to the snippet. 

The format is:

	@@include_keyword@@include_file


# Example

## C++
cin:

	# -*- mode: snippet -*-
	# name: cin
	# key: cin
	# --
	@@#include@@#include <iostream>
	std::cin >> 
	
When you type "cin" in a c++-mode buffer, and expand this snippet, this plugin will check if you have already inserted "#include \<iostream\>" in the header, and if not, insert it.

map:

	# -*- mode: snippet -*-
	# name: map
	# key: map
	# --
	@@#include@@#include <map>
	std::map<${1:int}, ${2:int}> ${3:m}
	
Another example of snippet.

## python

popen:

	# -*- mode: snippet -*-
	# name: popen
	# key: popen
	# --
	@@import@@import subprocess
	subprocess.Popen(${1:cmd}, shell=True)

	

# ATTETION
DO NOT FORGET to insert your first header file/import file manully to help this plugin locate header file area. If no header file exists, the new header file will be inserted right behind where the snippet expands.