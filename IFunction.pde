public static interface IFunction{
  float calculate(float... point);
  
  float[] gradient(float... point);
  
  
  //TODO: perhaps the next two functions should not be part of IFunction!
  
  /**
   * Maximum expected return value of the function. <br>
   * This is only used when plotting so it is not vital to define correctly. 
   */
  float functionMax();
  
  /**
   * Mainimum expected return value of the function. <br>
   * This is only used when plotting so it is not vital to define correctly. 
   */
  float functionMin();

}