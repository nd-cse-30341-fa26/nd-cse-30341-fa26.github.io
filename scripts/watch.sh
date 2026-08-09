#!/bin/sh

inotifywait -e close_write -r -m $(pwd) | \
    while read path action file; do
    	case $file in
    	    *.md|*.css) make install;;
    	esac
    done
