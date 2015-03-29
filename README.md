# yasnippet-inc
Help to insert header file automatically when expand yasnippet template. Buffer will be checked to avoid duplicated insertion of header file. The only requirement is that you have to write your first header file manully, otherwise this plugin doesn't know where is the header file area.


# Install
Copy content in yasnippet-inc.el to your .emacs file. Reopen emacs.

# Usage
Update or create new yasnippet, and add header file to the snippet. 

The format is:

	@@include_keyword_prefix@@include_file@@comment_symbol
    
where include_keyword_prefix is "#include" for C/C++ and "import" for python etc. comment_symbol is "//" for C++ and "#" for python etc. Note that open-close like comment like "/* */" for C is currently not supported.

The code matches the keyword by prefix, so even "#inc" is OK as long as you dont have the code start with the same prefix bofore header file area. For example, a buffer starts with:

	/*
	some text
	#include <iostream>
	*/
    
will not work correctly, because this plugin doesn't do grammer checking.

# Workflow
This piece of code firstly check lines of template contents start with "@@", and split the lines into 3 fileds. Then check from the start of the buffer to find the first line starts with include_keyword_prefix. From that line on, check line by line to see if the header file has already inserted, until finally meet a line that is not a comment(starts with comment_keyword) nor a blank line, nor a header file.

# Example

## C++
cin:

	# -*- mode: snippet -*-
	# name: cin
	# key: cin
	# --
	@@#inc@@#include <iostream>@@//
	`(progn (save-excursion) (goto-char (point-min)) (unless (re-search-forward
	"^using\\s-+namespace std;" nil 'no-errer) "std::"))
	`cout << $0

	
When you type "cin" in a c++-mode buffer, and expand the snippet, this plugin will check if you have already inserted "#include \<iostream\>" in the header, and if not, insert it.

map:

	# -*- mode: snippet -*-
	# name: map
	# key: map
	# --
	@@#inc@@#include <map>@@//
	`(progn (save-excursion) (goto-char (point-min)) (unless (re-search-forward
	"^using\\s-+namespace std;" nil 'no-errer) "std::"))
	`map<${1:int}, ${2:int}> ${3:m}
	
Another example of snippet.

## python

popen:

	# -*- mode: snippet -*-
	# name: popen
	# key: popen
	# --
	@@import@@import subprocess@@#
	subprocess.Popen(${1:cmd}, shell=True)
	

# ATTETION
DO NOT FORGET to insert your first header file/import file manully to help this plugin locate header file area. If no header file exists, the new header file will be inserted right behind where the snippet expands. 

# Acknowledgement
Thx to zhouchongzxc@newsmth for his help.
