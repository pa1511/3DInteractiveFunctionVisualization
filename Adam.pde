public static class AdamGradientDescent implements IOptimization{

  private float lr;
  private float d1;
  private float d2;
  private float[] r = new float[2];
  private float[] s = new float[2];
  private float t = 0;
  
  public AdamGradientDescent(float learning_rate,float decay1, float decay2){
    this.lr = learning_rate;
    this.d1 = decay1;
    this.d2 = decay2;
  }
  
  public void optimize(IFunction fun, float... point){
    float[] grad = fun.gradient(point);
    

    t++;
    
    for(int i=0; i<point.length;i++){
      s[i] = d1*s[i]+(1-d1)*grad[i];
      r[i] = d2*r[i]+(1-d2)*grad[i]*grad[i];
      
      float s_p = s[i]/(1-(float)Math.pow(d1,t));
      float r_p = r[i]/(1-(float)Math.pow(d2,t));
      
      point[i] -= lr*s_p/(sqrt(r_p)+1e-7);
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
      r[0]=r[1]=0;    
      s[0]=s[1]=0;    
      t = 0;
    }
  }

}