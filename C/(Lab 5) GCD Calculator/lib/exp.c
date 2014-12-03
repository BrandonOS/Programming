int Exp(int m, int n){
	if (m > 0 && n >= 0){
		if( n == 0)
			return 1;
		else if (n == 1)
			return m;
		else 
			return m * Exp(m, (n-1));
	
		
	}
	else 
		return -1;

}
