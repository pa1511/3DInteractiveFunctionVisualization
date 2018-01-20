public static class ChangingLrGradientDescent implements IOptimization{

  private double lr;
  private double startLr;
  private double endLr;
  private double lrStep;
  
  public ChangingLrGradientDescent(double startLR, double endLR, int iter){
    this.lr = startLR;
    this.startLr = startLR;
    this.endLr = endLR;
    this.lrStep = (startLR-endLR)/iter;
  }
  
  public void optimize(IFunction fun, double... point){
    double[] grad = fun.gradient(point);
    for(int i=0; i<point.length;i++){
      point[i] -= lr*grad[i];
    }
    lr -= lrStep;
    lr = Math.max(lr,endLr);
  }
  
  public String getInfo(){
    return "lr: " + lr;
  }
  
  public void adjust(char key_value){
    if(key_value=='r'){
      lr=startLr;
    }
  }

}  