for i in `seq 6 12`; do
	echo $i | python variance.py  >> results.txt
done
