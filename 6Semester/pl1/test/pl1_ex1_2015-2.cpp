#include <stdio.h>
#include <math.h>

unsigned short int happy_number[730];
unsigned short int buffer[730];

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
            else happy_number[i];
            flush_buffer();
            }
}
     

int main(void){
    int counter = 0;
    find_the_happy();
    int i, sum, temp;
    for(i=1000; i<1000000000; i++){
                temp = i;
                int m = (int) log10(temp)+1;
                sum = 0;
                for(int i=0; i<m; i++){
                        sum += (temp%10)*(temp%10);
                        temp = temp/10;
                }
            if(happy_number[sum]==1) counter++;
            }
    printf("%d\n", counter);
    return 0;
}
