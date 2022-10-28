#!/bin/bash

clear

flag=$1
second_flag=$2
SRCS="get_next_line.c get_next_line.h get_next_line_utils.c"
CFLAGS="-Werror -Wextra -Wall"

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

if [ $flag == n ] || [ $flag == "norm" ]
then
	norm $2
fi

if [ $flag == c ] || [ $flag == "compile" ]
then
	compile $2 $3
fi
