BEGIN {
data=0;
packets=0;
last_a=0.0;
}
/^r/&&/tcp/ {
data+=$6;
packets++;
}
/^r/&&/ack/ {
	last_a = $2; }
END{
printf("Total Data received\t: %d Bytes\n", data);
printf("Total Packets received\t: %d\n", packets);
printf("Last ack receive\t: %f\n",last_a);
}
