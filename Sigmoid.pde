public static class Sigmoid implements IFunction{

  public double calculate(double... point){
    double x = point[0];
    double z = point[1];
    return 2*(1.0/(1+Math.exp(-x))+1.0/(1+Math.exp(-z)));
  }
  
  public double[] gradient(double... point){
    double x = point[0];
    double vx = 1.0/(1+Math.exp(-x));
    double gx = 2*vx*(1-vx);

    double z = point[1];
    double vz = 1.0/(1+Math.exp(-z));
    double gz = 2*vz*(1-vz);

    return new double[]{gx,gz};
  }
    
  public double functionMax(){
    return 4;
  }
  
  public double functionMin(){
    return 0;
  }

}