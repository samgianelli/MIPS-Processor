#include <stdio.h>
#include <stdbool.h>
#include <math.h>

#define FRAMEI 16
#define FRAMEJ 16
#define WINDOWI 4
#define WINDOWJ 4



int main() {
	int l = WINDOWI;
	int k = WINDOWJ;
	bool hasFinished = false;
	int frame[FRAMEI][FRAMEJ];
	int window[WINDOWI][WINDOWJ] = { { 0,1,2,3},{ 10,11,12,13},{ 760,761,762,763},{ 790,791,792,793} };

	{	//Initialize the frame and window to test.
		int counter = 0;
		for (int ii = 0; ii < FRAMEI; ii++) {
			for (int jj = 0; jj < FRAMEJ; jj++) {
				frame[ii][jj] = counter;
				printf("%3d ", frame[ii][jj]);
				counter++;
			}
			printf("\n");
		}
		for (int ii = 0; ii < WINDOWI; ii++) {
			for (int jj = 0; jj < WINDOWJ; jj++) {
				printf("%3d ", window[ii][jj]);
				counter++;
			}
			printf("\n");
		}

	}


	//Start Traversing
	printf("\nStarting Diagonal Search:\n");

	int v0 = 0;
	int v1 = 0;
	int i = 0;
	int j = 0;
	int curI = 0;
	int curJ = 0;
	int currSum = 0;
	int bestSum = 10000;
	int* frameP = frame;

	//Check spot
	//frameP = frame + i;
	//frameP = frameP + j;
	//frameP = frame;
	//currSum = 0;


	while (hasFinished == false) {
		if (WINDOWI + i - 1 < FRAMEI && WINDOWJ + j - 1 < FRAMEJ) {
			frameP = frame + i;
			frameP = frameP + j;
			currSum = 0;
			for (int* p = window; p < window + WINDOWI; p = p + WINDOWJ) {
				for (int* q = p; q < p + WINDOWJ; q++) {
					currSum = currSum + abs(*q - *(frameP + (q - p)));
				}
				frameP = frameP + FRAMEJ;
			}
			/*if (bestSum == 0) {
			hasFinished = true;
			break;
			}*/
			if (currSum < bestSum) {
				bestSum = currSum;
				curI = i; curJ = j;
			}
		}
		printf("%d ", frame[i][j]);

		while (i != 0 && j != FRAMEJ - 1 - WINDOWJ) { 	//Diagonal Up
			i--; j++;
			//Check spot
			if (WINDOWI + i - 1 < FRAMEI && WINDOWJ + j - 1 < FRAMEJ) {
				frameP = frame + i;
				frameP = frameP + j;
				currSum = 0;
				for (int* p = window; p < window + WINDOWI; p = p + WINDOWJ) {
					for (int* q = p; q < p + WINDOWJ; q++) {
						currSum = currSum + abs(*q - *(frameP + (q - p)));
					}
					frameP = frameP + FRAMEJ;
				}
				/*if (bestSum == 0) {
				hasFinished = true;
				break;
				}*/
				if (currSum < bestSum) {
					bestSum = currSum;
					curI = i; curJ = j;
				}
			}
			printf("%d ", frame[i][j]);
		}
		if (j == FRAMEJ - 1 - WINDOWJ) {	//If at edge, move down
			i++;
		}
		else if (i == 0) {	//If at top, move right
			j++;
		}
		

		if (i == FRAMEI - 1 - WINDOWI && j == FRAMEJ - 1 - WINDOWJ) {
			hasFinished = true;
			break;
		}
		printf("\n");
		//Check spot
		if (WINDOWI + i - 1 < FRAMEI && WINDOWJ + j - 1 < FRAMEJ) {
			frameP = frame + i;
			frameP = frameP + j;
			currSum = 0;
			for (int* p = window; p < window + WINDOWI; p = p + WINDOWJ) {
				for (int* q = p; q < p + WINDOWJ; q++) {
					currSum = currSum + abs(*q - *(frameP + (q - p)));
				}
				frameP = frameP + FRAMEJ;
			}
			/*if (bestSum == 0) {
			hasFinished = true;
			break;
			}*/
			if (currSum < bestSum) {
				bestSum = currSum;
				curI = i; curJ = j;
			}
		}
		printf("%d ", frame[i][j]);
		while (j != 0 && i != FRAMEI - 1 - WINDOWI) { 	//Diagonal down
			i++; j--;
			//Check spot
			if (WINDOWI + i - 1 < FRAMEI && WINDOWJ + j - 1 < FRAMEJ) {
				frameP = frame + i;
				frameP = frameP + j;
				currSum = 0;
				for (int* p = window; p < window + WINDOWI; p = p + WINDOWJ) {
					for (int* q = p; q < p + WINDOWJ; q++) {
						currSum = currSum + abs(*q - *(frameP + (q - p)));
					}
					frameP = frameP + FRAMEJ;
				}
				/*if (bestSum == 0) {
				hasFinished = true;
				break;
				}*/
				if (currSum < bestSum) {
					bestSum = currSum;
					curI = i; curJ = j;
				}
			}
			printf("%d ", frame[i][j]);
		}
		if (i == FRAMEI - 1 - WINDOWI) {	//If all the way to the right we move down
			j++;
		}
		else if (j == 0) {	//We are at the top, we move right
			i++;
		}

		//Check spot
		if (WINDOWI + i - 1 < FRAMEI && WINDOWJ + j - 1 < FRAMEJ) {
			frameP = frame + i;
			frameP = frameP + j;
			currSum = 0;
			for (int* p = window; p < window + WINDOWI; p = p + WINDOWJ) {
				for (int* q = p; q < p + WINDOWJ; q++) {
					currSum = currSum + abs(*q - *(frameP + (q - p)));
				}
				frameP = frameP + FRAMEJ;
			}
			/*if (bestSum == 0) {
				hasFinished = true;
				break;
			}*/
			if (currSum < bestSum) {
				bestSum = currSum;
				curI = i; curJ = j;
			}
		}
		printf("%d ", frame[i][j]);
		if (i == FRAMEI - 1 - WINDOWI && j == FRAMEJ - 1 - WINDOWJ) {
			hasFinished = true;
			break;
		}
		

	}
	printf("\nBestSum: %d\nAt: %d %d\n", bestSum, curI, curJ);

	return 0;
}