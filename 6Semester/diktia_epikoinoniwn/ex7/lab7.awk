BEGIN {
	end1=0.0
	end2=0.0
	packet1=0
	packet2=0}

/^r/&&/tcp/ {
	if ($6 ==540){
	if($4 == 5 && $8 ==0){packet1++;
		if(packet1 == 120) end1 =$2;}
	
	if($4 ==7  && $8 ==1)
	{ packet2++;
		if(packet2 ==120) end2 =$2;}
		}}

END{
	printf("Packets receive id 1 %d and end time %f\n",packet1,end1);
	printf("Packets receive id 2 %d and end time %f\n",packet2,end2);
	}
