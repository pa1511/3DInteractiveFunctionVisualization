public static class MultyLocal implements IFunction{

  public float calculate(float... point){
    float x = point[0];
    float z = point[1];
    return sin(x*2)+sin(z*2)+x*x/10.0+z*z/10.0;
  }
  
  public float[] gradient(float... point){
    return new float[]{2*cos(2*point[0])+point[0]/10.0,2*cos(2*point[1])+point[1]/10.0};
  }
    
  public float functionMax(){
    return 6;
  }
  
  public float functionMin(){
    return -6;
  }

}