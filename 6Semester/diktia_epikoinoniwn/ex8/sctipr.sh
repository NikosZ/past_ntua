echo $1 >>res3.txt
ns lab8.tlc
awk -f lab8.awk < lab8.tr >> res3.txt
