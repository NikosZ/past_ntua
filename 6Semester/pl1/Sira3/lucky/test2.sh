#!/bin/bash
i=1468227
set -m
while [ $i -lt $1 ];
do
	./luck $i >>/media/zinc/LaCie/test2.txt &
	let i+=1;
done
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done
