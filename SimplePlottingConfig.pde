public static class SimplePlottingConfig implements IPlottingConfig{

  private float point_density;
  //
  private float varMin;
  private float varMax;
  private float interval;
  private float step;
  //
  private int ball_size;

  public SimplePlottingConfig(float point_density,float varMax,float varMin, float step, int ball_size){
    this.point_density = point_density;
    //
    this.varMin = varMin;
    this.varMax = varMax;
    this.interval = varMax-varMin;
    this.step = step;
    //
    this.ball_size = ball_size;
    
  }
  public float getPointDensity(){
    return point_density;
  }
  public float getVarMin(){
    return varMin;
  }
  public float getVarMax(){
    return varMax;
  }
  public float getInterval(){
    return interval;
  }
  public float getStep(){
    return step;
  }
  public int getBallSize(){
    return ball_size;
  }
}