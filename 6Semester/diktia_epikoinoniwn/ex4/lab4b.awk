BEGIN {
	data_0 =0;
	packets_0 =0;
	data_1 =0;
	packets_1 =0;
}
/^ r/&&/t c p / {
	flow_id = $8 ;
	i f ( flow_id == 0 ) {
		data_0 += $6 ;
		packets_0++;
		l a s t _ t s _ 0 = $2 ;
	}
	i f ( flow_id == 1 ) {
		data_1 += $6 ;
		packets_1++;
		l a s t _ t s _ 1 = $2 ;
	}
}
/^ r/&&/ack / {
	flow_id = $8 ;
	i f ( flow_id == 0 ) {
		last_ack_0 = $2 ;
	}
	i f ( flow_id == 1 ) {
		last_ack_1 = $2 ;
	}
}
END {
}
