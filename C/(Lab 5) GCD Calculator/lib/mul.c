int Mul(int m, int n){
	if (m >= 0 && n >= 0){
		if(n == 0)
			return 0;
		else if (n == 1)
			return m;
		else 
			return m + Mul(m, n-1);
		
	}
	else 
		return -1;
}
