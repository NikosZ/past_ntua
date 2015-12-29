#include <stdio.h>
#include <math.h>
#include <stdlib.h>

unsigned short int happy_number[730];
unsigned short int buffer[730];
unsigned short int Digit[10];
unsigned short int SquareOf[10];

void flush_buffer(void){
	for(int i=0; i<730; i++) buffer[i]=0;
}

void find_the_happy(void){
	int temp, sum;
	flush_buffer();
	for(int i=1; i<730; i++){
		temp = i; 
		while(temp!=1 && buffer[temp]==0){
			buffer[temp]=1;
			int m = (int) log10(temp)+1;
			sum = 0;
			for(int i=0; i<m; i++){
				sum += (temp%10)*(temp%10);
				temp = temp/10;
			}
			temp = sum;
		}
		if (temp==1) happy_number[i]=1;
		else happy_number[i]=0;
		flush_buffer();
	}
}

int main(void){
	find_the_happy();
	SquareOf[0]=0;
	SquareOf[1]=1;
	SquareOf[2]=4;
	SquareOf[3]=9;
	SquareOf[4]=16;
	SquareOf[5]=25;
	SquareOf[6]=36;
	SquareOf[7]=49;
	SquareOf[8]=64;
	SquareOf[9]=81;
	int A,B;
	printf("Insert the lower limit: ");
	scanf("%d", &A);
	printf("Insert the upper limit: ");
	scanf("%d", &B);
	int i;
	int sum=0;
	int temp=A;
	for(i=0; i<10; i++){
		Digit[i] = temp%10;
		sum += SquareOf[Digit[i]];
		temp = temp/10;
	}
	int NumberOfHappy;
	if (happy_number[sum]==1) NumberOfHappy=1;
	for(i=A+1; i<B+1; i++){
		if (Digit[0]==9){
			sum -= 81;
			Digit[0]=0;
			if (Digit[1]==9){
				sum -= 81;
				Digit[1]=0;
				if (Digit[2]==9){
					sum -= 81;
					Digit[2]=0;
					if (Digit[3]==9){
						sum -= 81;
						Digit[3]=0;
						if (Digit[4]==9){
							sum -= 81;						
							Digit[4]=0;
							if (Digit[5]==9){
								sum -= 81;						
								Digit[5]=0;
								if (Digit[6]==9){
									sum -= 81;
									Digit[6]=0;
									if (Digit[7]==9){
										sum -= 81;					
										Digit[7]=0;
										if (Digit[8]==9){
											sum -= 80;					
											Digit[8]=0;
											Digit[9]=1;
										}
										else { sum += SquareOf[Digit[8]+1]-SquareOf[Digit[8]]; Digit[8]++; }
									}
									else { sum += SquareOf[Digit[7]+1]-SquareOf[Digit[7]]; Digit[7]++; }
								}
								else { sum += SquareOf[Digit[6]+1]-SquareOf[Digit[6]]; Digit[6]++; }		
							}
							else { sum += SquareOf[Digit[5]+1]-SquareOf[Digit[5]]; Digit[5]++; }
						}
						else { sum += SquareOf[Digit[4]+1]-SquareOf[Digit[4]]; Digit[4]++; }
					}
					else { sum += SquareOf[Digit[3]+1]-SquareOf[Digit[3]]; Digit[3]++; }
				}
				else { sum += SquareOf[Digit[2]+1]-SquareOf[Digit[2]]; Digit[2]++; }
			}
			else { sum += SquareOf[Digit[1]+1]-SquareOf[Digit[1]]; Digit[1]++; }
		}
		else { sum += SquareOf[Digit[0]+1]-SquareOf[Digit[0]]; Digit[0]++; }
		if (sum<0) { printf("%d\n", i); return 0;}
		if (happy_number[sum]==1) NumberOfHappy++;
	}
	printf("%d\n", NumberOfHappy);
	return 0;
}
