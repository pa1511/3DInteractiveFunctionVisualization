public class DerivativeFunctionWrapper implements IFunction{

  private final double e;
  private final IFunction function;

  public DerivativeFunctionWrapper(IFunction function) {
    this(function,1e-6);
  }

  public DerivativeFunctionWrapper(IFunction function, double e) {
    this.e = e;
    this.function = function;
  }
  
  public double calculate(double... point) {
    return function.calculate(point);
  }
  

  public double[] gradient(double... point) {
    
    double[] gradient = new double[point.length];
    
    double divisionFactor = 12*e;
    for(int i=0; i<gradient.length; i++){

      double x = point[i];
      
      point[i] = x+2*e;
      double value1 = -1*calculate(point);
      
      point[i] = x+e;
      double value2 = 8*calculate(point);
      
      point[i] = x-e;
      double value3 = -8*calculate(point);
      
      point[i] = x-2*e;
      double value4 = calculate(point);
      
      point[i] = x;
      
      gradient[i] = (value1+value2+value3+value4)/(divisionFactor);
    }
    
    return gradient;
  }

  public  double functionMax(){
     return function.functionMax();
   }
    
   public double functionMin(){
     return function.functionMin();
   }
 }