#!/bin/bash

in_list () {
	LIST=$1
	TOFIND=$2
	for name in $(echo $LIST | tr '\n' ' ')
	do
		if [ $name = $TOFIND ]
		then
			return 0
			echo $TOFIND
		fi
	done
	return 1
}

check_repo () {
	FILES=$1
	LOCALPATH=$2
	for name in $FILES
	do
		cur_name=$name
		if ! in_list "$(ls $LOCALPATH)" $name
		then
			echo you dont\'t have $cur_name in your directory
			return 1
		fi
	done

	if [ $(ls $LOCALPATH | wc -l ) -ne 3 ]
	then
		echo you have some extra files in your directory
		return 1
	fi
	if [ $(norminette $LOCALPATH | grep Error | wc -l ) -gt 0 ]
	then
		echo Failed Norm
		cur=$PWD
		cd $LOCALPATH
		for file in $FILES
		do
			norminette $file | grep Error
		done
		cd $cur
		return 1
	fi
	return 0
}

check_
