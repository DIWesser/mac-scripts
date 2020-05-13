#!/bin/bash
#
# Calculator for terminal

printf "$@\n" | bc -ql
