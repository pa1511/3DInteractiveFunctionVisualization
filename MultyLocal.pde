public static class MultyLocal implements IFunction{

  public double calculate(double... point){
    double x = point[0];
    double z = point[1];
    return Math.sin(x*2)+Math.sin(z*2)+x*x/10.0+z*z/10.0;
  }
  
  public double[] gradient(double... point){
    return new double[]{2*Math.cos(2*point[0])+point[0]/10.0,2*Math.cos(2*point[1])+point[1]/10.0};
  }
    
  public double functionMax(){
    return 6;
  }
  
  public double functionMin(){
    return -6;
  }

}