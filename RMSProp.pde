public static class RMSProp implements IOptimization{

  private float lr;
  private float decay;
  private float[] r = new float[2];
  
  public RMSProp(float learning_rate,float decay){
    this.lr = learning_rate;
    this.decay = decay;
  }
  
  public void optimize(IFunction fun, float... point){
    
    float[] grad = fun.gradient(point);
    for(int i=0; i<point.length;i++){
      r[i] = decay*r[i]+(1-decay)*grad[i]*grad[i];
      point[i] -= lr*grad[i]/sqrt(1e-7+r[i]);
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