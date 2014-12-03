
void sortDept(struct employee *emply, int size_){
	int i, j;

	for(i = size_ - 1; i > 0; i--)	
		for(j = 0; j < i; j++)
			if( strcmp(emply[j].dept, emply[j + 1].dept) > 0)
				swap(emply, j, (j+1));		

	for (i = 0; i < size_; i++)
		printf(" %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", emply[i].key, emply[i].surName, emply[i].givenName, emply[i].dept, emply[i].payRate, emply[i].eyeColor);
}
