import java.nio.file.Paths;
import java.nio.file.Files;
import java.util.List;

public static class LearningSquaredErrorFunction implements IFunction{

  
  public static LearningSquaredErrorFunction load(String file,IPrototypeFunction prototype){
        
    List<String> lines;
    try{
      lines = Files.readAllLines(Paths.get(file));
    }
    catch(IOException e){
      throw new RuntimeException(e);
    }
    int N = lines.size();
    
    float[][] X = new float[N][];
    float[] y = new float[N];
    
    for(int i=0; i<N; i++){
      String line = lines.get(i);
      String[] lineElem = line.split(",");
      
      X[i] = new float[lineElem.length-1];

      for(int j=0; j<X[i].length;j++){
        X[i][j] = Float.parseFloat(lineElem[j]);
      }
      y[i] = Float.parseFloat(lineElem[lineElem.length-1]);
    }  
  
    return new LearningSquaredErrorFunction(X,y,prototype);  
  }
  
  
  
  //===================================================================================
  private final float[][] inputs;
  private final float[] values;
  private final IPrototypeFunction prototype;

  public LearningSquaredErrorFunction(float[][] X, float[] y, IPrototypeFunction prototypeFunction){
    this.inputs = X;
    this.values = y;
    this.prototype = prototypeFunction;
  }
  
  
  public float calculate(float... point){

    float error = 0;
    
    for(int i=0; i<inputs.length;i++){
      float v = prototype.calculate(point,inputs[i]);
      error+=Math.pow(v-values[i],2);
    }
    
    return error/inputs.length;
  }
  
  public float[] gradient(float... point){

    float[] gradient = new float[point.length];
    
    for(int i=0; i<inputs.length;i++){
      float v = prototype.calculate(point,inputs[i]);
      float[] gradi = prototype.gradient(point,inputs[i]);
      for(int j=0; j<gradient.length;j++){
        gradient[j]+=2*(v-values[i])*gradi[j];
      }
    }

    for(int j=0; j<gradient.length;j++){
        gradient[j]=gradient[j]/values.length;
    }

    return gradient;
  }
  
  public float functionMax(){
    //only used when plotting so it is not vital that this number is correct
    return 10;
  }
  
  public float functionMin(){
    return 0;
  }


}

public static interface IPrototypeFunction{
  
  public float calculate(float[] param,float[] Xi);
  
  public float[] gradient(float[] param,float[] Xi);

  public static LineFunction linePrototype = new LineFunction();


  public static class LineFunction implements IPrototypeFunction{
  
    public float calculate(float[] param,float[] Xi){
      float k = param[0];
      float l = param[1];
      
      return k*Xi[0]+l;
    }
  
    public float[] gradient(float[] param,float[] Xi){
    
        return new float[]{Xi[0],1};
    }
    
  }
}