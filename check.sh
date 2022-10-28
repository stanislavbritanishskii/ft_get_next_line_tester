#!/bin/bash

clear
. ./funcs.sh
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



if [ -z $flag ]

then
	echo "no params"
	if ! check_repo "$SRCS" $LOCALPATH
	then
		echo "bad repo"
		exit 1
	fi
	echo your repo seems to be good
	compile ""


elif [ $flag == n ] || [ $flag == "norm" ]
then
	norm $2


elif [ $flag == c ] || [ $flag == "compile" ]
then
	compile $2 $3
fi
