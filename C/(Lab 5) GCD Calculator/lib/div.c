int Div(int m, int n){
	if (m >= 0 && n > 0){
		if (n == 1)
			return m;
		else if (m == 0)
			return m;
		else
			return 1 + Div(m - n, n);
		
	}
	else 
		return -1;
}
