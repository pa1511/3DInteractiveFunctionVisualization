public static class Square implements IFunction{

  public double calculate(double... point){
    return point[0]*point[0]/5+point[1]*point[1]/5-2;
  }
  
  public double[] gradient(double... point){
    return new double[]{point[0]/5,point[1]/5};
  }
    
  public double functionMax(){
    return 1;
  }
  
  public double functionMin(){
    return -2;
  }

}