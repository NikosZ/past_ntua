#!/bin/bash
i=0
while [ $i -lt $1 ];
do
	printf "$i " >> test.txt;
	./a.out $i >>test.txt;
	let i+=1;
done

