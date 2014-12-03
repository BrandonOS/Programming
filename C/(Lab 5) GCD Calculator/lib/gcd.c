int gcd(int m, int n){
	if (m >= 0 && n >= 0){
		if (n == 0)
			return m;
		else
			return gcd(n, m % n);
	}
	else 
		return -1;
}

