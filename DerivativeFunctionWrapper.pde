public class DerivativeFunctionWrapper implements IFunction{

  private final float e;
  private final IFunction function;

  public DerivativeFunctionWrapper(IFunction function) {
    this(function,1e-6);
  }

  public DerivativeFunctionWrapper(IFunction function, float e) {
    this.e = e;
    this.function = function;
  }
  
  public float calculate(float... point) {
    return function.calculate(point);
  }
  

  public float[] gradient(float... point) {
    
    float[] gradient = new float[point.length];
    
    float divisionFactor = 12*e;
    for(int i=0; i<gradient.length; i++){

      float x = point[i];
      
      point[i] = x+2*e;
      float value1 = -1*calculate(point);
      
      point[i] = x+e;
      float value2 = 8*calculate(point);
      
      point[i] = x-e;
      float value3 = -8*calculate(point);
      
      point[i] = x-2*e;
      float value4 = calculate(point);
      
      point[i] = x;
      
      gradient[i] = (value1+value2+value3+value4)/(divisionFactor);
    }
    
    return gradient;
  }

  public  float functionMax(){
     return function.functionMax();
   }
    
   public float functionMin(){
     return function.functionMin();
   }
 }