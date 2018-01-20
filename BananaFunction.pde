public static class BananaFunction implements IFunction{

  public double calculate(double... point){
    double x = point[0];
    double z = point[1];
    
    return ((z-x*x)*(z-x*x) + (1-x)*(1-x))/20;
  }
  
  public double[] gradient(double... point){
    double x = point[0];
    double z = point[1];
    
    return new double[]{ (4*x*x*x+(2-4*z)*x-2)/20,(z-x*x)/10};
  }
    
  public double functionMax(){
    return 5;
  }
  
  public double functionMin(){
    return 0;
  }

}