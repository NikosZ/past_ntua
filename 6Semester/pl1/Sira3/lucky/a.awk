BEGIN{
time =0.0
t=0;}
/S/{
t=t+1;
time = time + $2;}
END{
printf("%d\n",t);
printf("%f",time);}