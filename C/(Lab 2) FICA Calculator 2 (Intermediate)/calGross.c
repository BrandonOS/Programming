int calGross(int hours, double payRate){
    int gross;

   gross = (hours <= 40) ? hours * payRate : (payRate * 40) + (40 - hours) * payRate ;	
    
    return gross;
}
