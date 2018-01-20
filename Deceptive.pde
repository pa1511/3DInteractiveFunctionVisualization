public static class Deceptive implements IFunction{

  public double calculate(double... point){
    return Math.sin(point[0])+1+Math.sin(point[0]/2);
  }
  
  public double[] gradient(double... point){
    return new double[]{Math.cos(point[0])+Math.cos(point[0]/2)/2, 0};
  }
    
  public double functionMax(){
    return 8;
  }
  
  public double functionMin(){
    return -8;
  }

}