public static class NesterovMomentGradientDescent implements IOptimization{

  private double lr;
  private double alpha;
  private double[] velocity = new double[2];
  private double[] pointTemp = new double[2];
  
  public NesterovMomentGradientDescent(double lr, double alpha){
    this.lr = lr;
    this.alpha = alpha;
  }
  
  public void optimize(IFunction fun, double... point){
    
    for(int i=0; i<pointTemp.length;i++){
      velocity[i] *= alpha;
      pointTemp[i] = point[i]+velocity[i];
    }  
    
    double[] grad = fun.gradient(pointTemp);
    
    for(int i=0; i<point.length;i++){
      velocity[i] -= lr*grad[i];
      point[i] += velocity[i];
    }
  }
  
  public String getInfo(){
    return "lr: " + lr;
  }
  
  public void adjust(char key_value){
    if(key_value=='+'){
      lr+=0.001;
    }
    else if(key_value=='-'){
      lr-=0.001;
    }
    else if(key_value=='*'){
      lr*=2;
    }
    else if(key_value=='/'){
      lr/=2;
    }
  }

}  