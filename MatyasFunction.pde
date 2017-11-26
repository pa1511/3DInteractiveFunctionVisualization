public static class Matyas implements IFunction{

  public float calculate(float... point){
    float x = point[0];
    float z = point[1];
    
    return 0.26*(x*x+z*z)-0.48*x*z;
  }
  
  public float[] gradient(float... point){
    float x = point[0];
    float z = point[1];
    
    return new float[]{0.26*2*x-0.48*z,0.26*2*z-0.48*x};
  }
    
  public float functionMax(){
    return 10;
  }
  
  public float functionMin(){
    return -1;
  }

}