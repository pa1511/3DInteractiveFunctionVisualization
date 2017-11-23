public static class AdaGradGradientDescent implements IOptimization{

  private float lr;
  private float[] r = new float[2];
  
  public AdaGradGradientDescent(float learning_rate){
    this.lr = learning_rate;
  }
  
  public void optimize(IFunction fun, float... point){
    
    float[] grad = fun.gradient(point);
    for(int i=0; i<point.length;i++){
      r[i] += grad[i] * grad[i];
      point[i] -= lr*grad[i]/(1e-6+sqrt(r[i]));
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
    else if(key_value=='r'){
      r[0] = r[1] = 0;
    }
  }

}