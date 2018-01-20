public static interface IOptimization{
  void optimize(IFunction function, double... point);
  String getInfo();
  void adjust(char command);
}