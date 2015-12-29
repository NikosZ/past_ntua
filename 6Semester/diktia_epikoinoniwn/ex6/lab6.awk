BEGIN {
	sum_delay = 0;
	bufferspace = 100000;
	total_pkts_sent = 0;
	total_pkts_recv = 0;
	total_pkts_dropped = 0;
	last=0;

	# Do we need to fix the decimal mark?
	if (sprintf(sqrt(2)) ~ /,/) dmfix = 1;
}
{
	# Apply dm fix if needed
	if (dmfix) sub(/\./, ",", $0);
}
/^h/&&/cbr/ {
	total_pkts_sent++;
}
/^d/&&/cbr/ {
	total_pkts_dropped++;
}
/^-/&&/cbr/ {
	sendtimes[$12%bufferspace] = $2;
}
/^r/&&/cbr/ {
	total_pkts_recv++;
	sum_delay += $2 - sendtimes[$12%bufferspace];
	last=$2;
}
END {
	printf("Total Packets sent\t: %d\n", total_pkts_sent);
	printf("Total Packets received\t: %d\n", total_pkts_recv);
	printf("Total Packets dropped\t: %d\n", total_pkts_dropped);
	printf("Average Delay\t\t: %f sec\n", (1.0 * sum_delay)/ total_pkts_recv);
	printf("Last packet\t :%f \n",last);
}
