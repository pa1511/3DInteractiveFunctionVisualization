public static class Eliptic implements IFunction{

  public double calculate(double... point){
    return point[0]*point[0]/20+point[1]*point[1]/200;
  }
  
  public double[] gradient(double... point){
    return new double[]{point[0]/20,point[1]/200};
  }
    
  public double functionMax(){
    return 6;
  }
  
  public double functionMin(){
    return 0;
  }

}