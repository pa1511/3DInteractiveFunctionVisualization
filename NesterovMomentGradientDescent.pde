public static class NesterovMomentGradientDescent implements IOptimization{

  private float lr;
  private float alpha;
  private float[] velocity = new float[2];
  private float[] pointTemp = new float[2];
  
  public NesterovMomentGradientDescent(float lr, float alpha){
    this.lr = lr;
    this.alpha = alpha;
  }
  
  public void optimize(IFunction fun, float... point){
    
    for(int i=0; i<pointTemp.length;i++){
      velocity[i] *= alpha;
      pointTemp[i] = point[i]+velocity[i];
    }  
    
    float[] grad = fun.gradient(pointTemp);
    
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