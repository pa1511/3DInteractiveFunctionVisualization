public static class MomentGradientDescent implements IOptimization{

  private double lr;
  private double[] decay_policy;
  private double[] moment = new double[2];
  
  public MomentGradientDescent(double learning_rate,double[] decay_policy){
    this.lr = learning_rate;
    this.decay_policy = decay_policy;
  }
  
  public void optimize(IFunction fun, double... point){
    double[] grad = fun.gradient(point);
    
    for(int i=0; i<point.length;i++){
      moment[i] += grad[i];
      point[i] -= lr*moment[i];
      moment[i] *= decay_policy[i];
    }
  }
  
  public String getInfo(){
    return "lr: " + lr + " decay: " + java.util.Arrays.toString(decay_policy);
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