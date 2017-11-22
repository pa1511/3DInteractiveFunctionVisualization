public static interface IOptimization{
  void optimize(IFunction function, float... point);
  String getInfo();
  void adjust(char command);
}