// CS1010 AY2014/5 Semester 1 PE1 Ex2
// happy.c
//
// This program computes and compares the number of happy numbers
// in two given ranges.
//
// Written by: Jin

#include <stdio.h>
#include <math.h>

int computeHappyNumbers(int lower, int upper);
int isHappyNumber(int number);
int checkSum(int sum);
int sumOfDigitSquares(int number);

int main(void){
	int lower1, upper1, lower2, upper2, number1, number2;
	printf("Enter first range: ");
	scanf("%d %d", &lower1, &upper1);
	
	printf("Enter second range: ");
	scanf("%d %d", &lower2, &upper2);

	number1 = computeHappyNumbers(lower1, upper1);
	number2 = computeHappyNumbers(lower2, upper2);

	printf("The numbers of happy numbers in the two ranges are: %d %d\n", number1, number2);

	if (number1 > number2)
		printf("There are more happy numbers in the first range.\n");
	else if (number1 < number2)
		printf("There are more happy numbers in the second range.\n");
	else
		printf("The numbers of happy numbers in both ranges are the same.\n");

	return 0;
}

int computeHappyNumbers(int lower, int upper){
	int counter = 0, i;
	for (i=lower; i<=upper; i++){
		if (isHappyNumber(i))
			counter++;
	}

	return counter;
}

int isHappyNumber(int number){
	while (!checkSum(number)){
		number = sumOfDigitSquares(number);
	}

	return number==1;
}

int sumOfDigitSquares(int number){
	int sum = 0;

	while (number != 0){
		sum += pow(number%10, 2);
		number /= 10;
	}

	return sum;
}

int checkSum(int sum){
	int i, sums[10] = {0, 1, 4, 16, 20, 37, 42, 58, 89, 145};

	for (i=0; i < 10;i++)
		if (sum == sums[i])
			return 1;

	return 0;
}
