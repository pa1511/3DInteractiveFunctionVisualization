public static class BananaFunction implements IFunction{

  public float calculate(float... point){
    float x = point[0];
    float z = point[1];
    
    return ((z-x*x)*(z-x*x) + (1-x)*(1-x))/20;
  }
  
  public float[] gradient(float... point){
    float x = point[0];
    float z = point[1];
    
    return new float[]{ (4*x*x*x+(2-4*z)*x-2)/20,(z-x*x)/10};
  }
    
  public float functionMax(){
    return 5;
  }
  
  public float functionMin(){
    return 0;
  }

}