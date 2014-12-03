double calFica(int ytd, double gross, int ficaLimit, double ficaRate){


	double tax=0.00;
	
	(ytd >= ficaLimit) ? tax = 0.00 : (ytd + gross <= ficaLimit) ? (tax = gross * ficaRate) : (tax = (ficaLimit - ytd) * ficaRate);

        return tax;	
}
