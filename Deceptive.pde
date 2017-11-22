public static class Deceptive implements IFunction{

  public float calculate(float... point){
    return sin(point[0])+1+sin(point[0]/2);
  }
  
  public float[] gradient(float... point){
    return new float[]{cos(point[0])+cos(point[0]/2)/2, 0};
  }
    
  public float functionMax(){
    return 8;
  }
  
  public float functionMin(){
    return -8;
  }

}