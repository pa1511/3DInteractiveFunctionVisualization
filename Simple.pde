public static class Eliptic implements IFunction{

  public double calculate(double... point){
    return point[0]*point[0]/2.5+point[1]*point[1]/10-2;
  }
  
  public double[] gradient(double... point){
    return new double[]{point[0]/2.5,point[1]/10};
  }
    
  public double functionMax(){
    return 3;
  }
  
  public double functionMin(){
    return -2;
  }

}