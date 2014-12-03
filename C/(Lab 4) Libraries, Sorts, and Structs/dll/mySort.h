#ifndef __myLib
#define __myLib

struct employee{
	 int key;	
	 char surName[14];
	 char givenName[14];
	 char dept[24];
	 double payRate;
	 char eyeColor[8];	
};

extern void swap(struct employee *, int, int);
extern void bubbleUp(struct employee *);
extern void straightInsertion(struct employee *);
extern void addrPointerSort(struct employee *, int *);
extern void ptrPrintToFile(struct employee *, int *);
extern void arraySwap(int [], int, int);



#endif
