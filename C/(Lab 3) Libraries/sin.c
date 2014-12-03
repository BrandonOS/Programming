double Sine(float x){
	(x > 5) ? x = M_PI * x / 180 : printf("\n");		// Calculate radian equivalent


	double ans = 0, temp, difference = 1, total;
	int j, n = 2;
	
	for(j = 1; difference > .00000001; j++, n++){		//Taylor Series
		temp = ans;					//Store previous value	
		ans = pow(-1, n) * pow(x, j) / fact(j);		//Calculate next value
		total += ans;					//Add next value to total
		difference = temp + ans;			//  Check how much difference has changed
	
		j++;		
	}

	

	return total;
}

int fact(int x){
	int i, fact = 1;
	if (x < 0)
		return -1;
	else if (x == 0)
		return 1;

	for (i = 1; i <= x; i++)
		fact *= i;

	return fact;
}

