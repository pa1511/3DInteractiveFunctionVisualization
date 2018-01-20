public static class SimplePlottingConfig implements IPlottingConfig{

  private double point_density;
  //
  private double varMin;
  private double varMax;
  private double interval;
  private double step;
  //
  private int ball_size;

  public SimplePlottingConfig(double point_density,double varMax,double varMin, double step, int ball_size){
    this.point_density = point_density;
    //
    this.varMin = varMin;
    this.varMax = varMax;
    this.interval = varMax-varMin;
    this.step = step;
    //
    this.ball_size = ball_size;
    
  }
  public double getPointDensity(){
    return point_density;
  }
  public double getVarMin(){
    return varMin;
  }
  public double getVarMax(){
    return varMax;
  }
  public double getInterval(){
    return interval;
  }
  public double getStep(){
    return step;
  }
  public int getBallSize(){
    return ball_size;
  }
}