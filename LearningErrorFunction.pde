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
    
    double[][] X = new double[N][];
    double[] y = new double[N];
    
    for(int i=0; i<N; i++){
      String line = lines.get(i);
      String[] lineElem = line.split(",");
      
      X[i] = new double[lineElem.length-1];

      for(int j=0; j<X[i].length;j++){
        X[i][j] = Double.parseDouble(lineElem[j]);
      }
      y[i] = Double.parseDouble(lineElem[lineElem.length-1]);
    }  
  
    return new LearningSquaredErrorFunction(X,y,prototype);  
  }
  
  
  
  //===================================================================================
  private final double[][] inputs;
  private final double[] values;
  private double scale = 10;
  private final IPrototypeFunction prototype;

  public LearningSquaredErrorFunction(double[][] X, double[] y, IPrototypeFunction prototypeFunction){
    this.inputs = X;
    this.values = y;
    this.prototype = prototypeFunction;
  }
  
  
  public double calculate(double... point){

    double error = 0;
    
    for(int i=0; i<inputs.length;i++){
      double v = prototype.calculate(point,inputs[i]);
      error+=Math.pow(v-values[i],2);
    }
    
    return error/inputs.length/scale;
  }
  
  public double[] gradient(double... point){

    double[] gradient = new double[point.length];
    
    for(int i=0; i<inputs.length;i++){
      double v = prototype.calculate(point,inputs[i]);
      double[] gradi = prototype.gradient(point,inputs[i]);
      for(int j=0; j<gradient.length;j++){
        gradient[j]+=2*(v-values[i])*gradi[j]/scale;
      }
    }

    for(int j=0; j<gradient.length;j++){
        gradient[j]=gradient[j]/values.length;
    }

    return gradient;
  }
  
  public double functionMax(){
    //only used when plotting so it is not vital that this number is correct
    return 10;
  }
  
  public double functionMin(){
    return 0;
  }


}

public static interface IPrototypeFunction{
  
  public double calculate(double[] param,double[] Xi);
  
  public double[] gradient(double[] param,double[] Xi);

  public static LineFunction linePrototype = new LineFunction();


  public static class LineFunction implements IPrototypeFunction{
  
    public double calculate(double[] param,double[] Xi){
      double k = param[0];
      double l = param[1];
      
      return k*Xi[0]+l;
    }
  
    public double[] gradient(double[] param,double[] Xi){
    
        return new double[]{Xi[0],1};
    }
    
  }
}