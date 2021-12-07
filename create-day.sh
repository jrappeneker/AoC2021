#! /bin/bash
if [ ! -f tests/$1/0/input ]; then
mkdir -p tests/$1/0/
echo "0" > tests/$1/0/input
echo "0" > tests/$1/0/answer

mkdir input/$1/
echo "0" > input/$1/input
DATE=`date "+%Y/%m/%d"`
sed -e "s;%DATE%;$DATE;g" -e "s;%DAY%;$1;g" day-template > AoC2021/Day$1.swift
echo "Day $1 files created."
open AoC2021/
fi

