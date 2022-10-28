#!/bin/bash

clear

flag=$1
second_flag=$2
SRCS="get_next_line.c get_next_line.h get_next_line_utils.c"
CFLAGS="-Werror -Wextra -Wall"

LOCALPATH=../get_next_line

norm () {
	VAR=$1
	if [ -z $VAR ]
	then
		norminette $SRCS
	else
		norminette $VAR
	fi
}

compile () {
	SRC=$1
	if [ -z $SRC ]
	then
		echo "no source is given"
		return
	fi
	RES=$2
	if [ -z $RES ]
	then
		RES="$(basename $SRC .c)"
	fi
	ar rcs temp.o $SRCS
	gcc $CFLAGS temp.o $SRC -o $RES
	./$RES
	rm $RES temp.o
}

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
	for name in $SRCS
	do
		if ! in_list "$(ls $LOCALPATH)" $name
		then
			return 1
		fi
	done
	return 0
}

if [ -z $flag ]

then
	echo "no params"
	if ! check_repo
	then
		echo "bad repo"
	fi



elif [ $flag == n ] || [ $flag == "norm" ]
then
	norm $2


elif [ $flag == c ] || [ $flag == "compile" ]
then
	compile $2 $3
fi
