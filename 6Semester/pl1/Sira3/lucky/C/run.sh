for line in `cat AAA.txt`;
do
	./a.out $line >> c.txt
done
