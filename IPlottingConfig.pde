public static interface IPlottingConfig{

  double getPointDensity();
  //
  double getVarMin();
  double getVarMax();
  double getInterval();
  double getStep();
  //
  int getBallSize();

}