public static interface IFunction{
  double calculate(double... point);
  
  double[] gradient(double... point);
  
  
  //TODO: perhaps the next two functions should not be part of IFunction!
  
  /**
   * Maximum expected return value of the function. <br>
   * This is only used when plotting so it is not vital to define correctly. 
   */
  double functionMax();
  
  /**
   * Mainimum expected return value of the function. <br>
   * This is only used when plotting so it is not vital to define correctly. 
   */
  double functionMin();

}