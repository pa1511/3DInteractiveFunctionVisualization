public static class GradientDescent implements IOptimization{

  private float lr;
  
  public GradientDescent(float learning_rate){
    this.lr = learning_rate;
  }
  
  public void optimize(IFunction fun, float... point){
    float[] grad = fun.gradient(point);
    for(int i=0; i<point.length;i++){
      point[i] -= lr*grad[i];
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