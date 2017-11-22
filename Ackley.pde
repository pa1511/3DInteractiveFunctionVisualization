public static class Ackley implements IFunction{

  public float calculate(float... point){
    float x = point[0];
    float z = point[1];
    
    return (float)(-20*exp(-0.2*sqrt((x*x+z*z)/2))-exp((cos(2*PI*x)+cos(2*PI*z))/2))/3+5;
  }
  
  public float[] gradient(float... point){
    //TODO: calculate gradient
    return new float[]{0,0};
  }
    
  public float functionMax(){
    return 1;
  }
  
  public float functionMin(){
    return -3;
  }

}