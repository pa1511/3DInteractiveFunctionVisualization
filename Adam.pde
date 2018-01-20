public static class AdamGradientDescent implements IOptimization{

  private double lr;
  private double d1;
  private double d2;
  private double[] r = new double[2];
  private double[] s = new double[2];
  private double t = 0;
  
  public AdamGradientDescent(double learning_rate,double decay1, double decay2){
    this.lr = learning_rate;
    this.d1 = decay1;
    this.d2 = decay2;
  }
  
  public void optimize(IFunction fun, double... point){
    double[] grad = fun.gradient(point);
    

    t++;
    
    for(int i=0; i<point.length;i++){
      s[i] = d1*s[i]+(1-d1)*grad[i];
      r[i] = d2*r[i]+(1-d2)*grad[i]*grad[i];
      
      double s_p = s[i]/(1-(double)Math.pow(d1,t));
      double r_p = r[i]/(1-(double)Math.pow(d2,t));
      
      point[i] -= lr*s_p/(Math.sqrt(r_p)+1e-7);
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