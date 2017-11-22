public static class Sigmoid implements IFunction{

  public float calculate(float... point){
    float x = point[0];
    float z = point[1];
    return 2*(1.0/(1+exp(-x))+1.0/(1+exp(-z)));
  }
  
  public float[] gradient(float... point){
    float x = point[0];
    float vx = 1.0/(1+exp(-x));
    float gx = 2*vx*(1-vx);

    float z = point[1];
    float vz = 1.0/(1+exp(-z));
    float gz = 2*vz*(1-vz);

    return new float[]{gx,gz};
  }
    
  public float functionMax(){
    return 4;
  }
  
  public float functionMin(){
    return 0;
  }

}