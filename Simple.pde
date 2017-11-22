public static class Simple implements IFunction{

  public float calculate(float... point){
    return point[0]*point[0]/20+point[1]*point[1]/200;
  }
  
  public float[] gradient(float... point){
    return new float[]{point[0]/20,point[1]/200};
  }
    
  public float functionMax(){
    return 6;
  }
  
  public float functionMin(){
    return 0;
  }

}