#!/bin/bash

while read -r plugin; do
	printf "Installing %s plugin...\n" "${plugin}"
	./embulk gem install "${plugin}"
done < plugins.txt

printf "All plugins have been installed... Exiting!\n"
