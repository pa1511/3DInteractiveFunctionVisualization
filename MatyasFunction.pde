public static class Matyas implements IFunction{

  public double calculate(double... point){
    double x = point[0];
    double z = point[1];
    
    return 0.26*(x*x+z*z)-0.48*x*z;
  }
  
  public double[] gradient(double... point){
    double x = point[0];
    double z = point[1];
    
    return new double[]{0.26*2*x-0.48*z,0.26*2*z-0.48*x};
  }
    
  public double functionMax(){
    return 10;
  }
  
  public double functionMin(){
    return -1;
  }

}