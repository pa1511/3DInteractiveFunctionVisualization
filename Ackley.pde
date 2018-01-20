public static class Ackley implements IFunction{

  public double calculate(double... point){
    double x = point[0];
    double z = point[1];
    
    return (double)(-20*Math.exp(-0.2*Math.sqrt((x*x+z*z)/2))-Math.exp((Math.cos(2*PI*x)+Math.cos(2*PI*z))/2))/3+5;
  }
  
  public double[] gradient(double... point){
    //TODO: calculate gradient
    return new double[]{0,0};
  }
    
  public double functionMax(){
    return 1;
  }
  
  public double functionMin(){
    return -3;
  }

}