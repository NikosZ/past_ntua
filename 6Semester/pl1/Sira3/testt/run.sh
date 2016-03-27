for line in `cat AAA.txt`;
do
	swipl -G2g -q -s ../prolog_yap/lucky_numbers_testing.pl -g "lucky([$line])." -t halt. >> pl.txt
done
