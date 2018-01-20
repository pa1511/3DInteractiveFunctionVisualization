//==================================================================
void setup() {
  size(1000, 1000,P3D);
  loop();
  frameRate(60);

  startOptimization(100);
}

void startOptimization(final int rate){
  Thread t = new Thread(new Runnable(){
    public void run(){
      while(true){
        optimizer.optimize(fun,point);
        try{
          Thread.sleep(rate);
        }catch(Exception e){
        }
      }
    }
  
  });
  t.setDaemon(true);
  t.start();

  surface.setResizable(true);
}

//==================================================================
//Start point
double[] point = new double[2];

//==================================================================
//Current function

//EXAMPLE1
//IFunction fun = new Deceptive();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(4,10,-10,2,10);

//EXAMPLE2
//IFunction fun = new MultyLocal();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(8,6,-6,2,10);

//EXAMPLE3
//IFunction fun = new Eliptic();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(4,10,-10,1,10);

//EXAMPLE4
//IFunction fun = new Sigmoid();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(4,10,-10,1,10);

//EXAMPLE5
IFunction fun = new DerivativeFunctionWrapper(new Ackley());
IPlottingConfig plottingConfig = new SimplePlottingConfig(20,3,-3,2,10);

//EXAMPLE6
//IFunction fun = LearningSquaredErrorFunction.load("/home/paf/workspace-java/processing-projects/Function3DInteractiveVisual/data/linear-noise-data.txt",IPrototypeFunction.linePrototype);
//IPlottingConfig plottingConfig = new SimplePlottingConfig(20,3,-3,2,10);

//EXAMPLE7
//IFunction fun = new BananaFunction();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(6,8,-8,1,10);

//EXAMPLE8
//IFunction fun = new Matyas();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(8,5,-5,1,10);

boolean smood = false;

//==================================================================
//Optimization algorithm
IOptimization optimizer = //new GradientDescent(0.01);
                          //new MomentGradientDescent(0.05,new double[]{0.8,0.8});
                          //new ChangingLrGradientDescent(2,0.01,500);
                          //new NesterovMomentGradientDescent(2,0.8);
                          //new AdaGradGradientDescent(1);
                          //new RMSProp(1,0.4);
                          new AdamGradientDescent(2.5,0.9,0.999);
//==================================================================
//Plotting config
                                 
double point_density = plottingConfig.getPointDensity();
double varMin = plottingConfig.getVarMin();
double varMax = plottingConfig.getVarMax();
double interval = varMax-varMin;
double step = plottingConfig.getStep();
int ball_size = plottingConfig.getBallSize();

//
double scale = 0.5;
//
int rot_x = 180;
int rot_y = 180; 
//
double t_x = width;
double t_y = height/2;

ICoordinateSystem coordinateSystem = //new BoxCoordinateSystem();
                                     new LineCoordinateSystem();
//==================================================================
//Plotting

void draw() {
  
  //
  translate(width*2/3,height*7/10);
  //
  scale((float)scale);
  //
  translate((float)t_x,(float)t_y,0f);
  rotateX(radians(rot_x));
  rotateY(radians(rot_y));
  //
  background(0);
  //
  String info = optimizer.getInfo();
  drawOptimizerInfo(info);
  //
  
  //
  stroke(255,255,255);
  coordinateSystem.drawCoordinateSystem();
  //
  plotFunction();
  //
  drawPoint(point[0],point[1]);
  //
  //

}

void plotFunction(){

  double fpStep = step/point_density;
  
  double fMin = fun.functionMin();
  double fInterval = fun.functionMax()-fun.functionMin();
  
  for (double z= varMin; z<=varMax; z+=fpStep) {
    double pz1 = scaleZToPz(z);
    double pz2 = scaleZToPz(z+fpStep);
    for (double x = varMin; x<=varMax; x+=fpStep) {
      double px1 = scaleXToPx(x);
      double px2 = scaleXToPx(x+fpStep);
     
      double y1 = fun.calculate(x,z);
      double y2 = fun.calculate(x+fpStep,z+fpStep);
      double y3 = fun.calculate(x+fpStep,z);
      double y4 = fun.calculate(x,z+fpStep);
      
      
      double py1 = scaleYToPy(y1);
      double py2 = scaleYToPy(y2);
      double py3 = scaleYToPy(y3);
      double py4 = scaleYToPy(y4);
    
      double yAvg = (y1+y2+y3+y4)/4.0;
    
      int r = (int)(255*(yAvg-fMin)/fInterval); 
    
      if(smood)
        noStroke();
        
      fill(r,255-r,0);
      
      beginShape(QUAD_STRIP);
      vertex((float)px1, (float)py1, (float)pz1);
      vertex((float)px2, (float)py3, (float)pz1);
      vertex((float)px1, (float)py4, (float)pz2);
      vertex((float)px2, (float)py2, (float)pz2);
      endShape(CLOSE);
      
    }
  }
  
}

void drawPoint(double x, double z){
  stroke(255,255,255);
  
  double px = scaleXToPx(x);
  double pz = scaleZToPz(z);
   
  double y = fun.calculate(x,z);
  double py = scaleYToPy(y); 
   
  translate((float)px, (float)py+ball_size, (float)pz);
  sphere(ball_size);
}

void drawOptimizerInfo(String info){
  fill(255,255,255);
  rotateZ(radians(180));
  textSize(50);
  text(info, -width, -height*1.1); 
  rotateY(radians(-90));
  text(info, 0, -height*1.1); 
  rotateY(radians(90));
  rotateZ(radians(-180));
}

private double scaleXToPx(double x){
  return width*(x-varMin)/interval;
}

private double scaleYToPy(double y){
  return height*(y-varMin)/interval;
}

private double scaleZToPz(double z){
  return width*(z-varMin)/interval;
}

//==================================================================
//interactions

void mouseWheel(MouseEvent event){
  double e = event.getCount();
  double scaleChange = 0.01*e;
  scale -= scaleChange;
}

double ms_x = 0;
double ms_y = 0;

void mousePressed(MouseEvent event){
  int button = event.getButton();
  if(button==LEFT){
    ms_x = event.getX();
    ms_y = event.getY();
  }
}

double lp_x = 0;
double lp_y = 0;

void mouseDragged(MouseEvent event){
  int button = event.getButton();
  if(button==LEFT){
    t_x += (event.getX()-ms_x)/30;
    t_y += (event.getY()-ms_y)/30;
    // divided by 30 to reduce translation speed
  }
  else if(button==RIGHT){
    double y = event.getY();
    if(lp_y-y>0)
      rot_x+=event.getCount();
    else
      rot_x-=event.getCount();
    lp_y = y;
  }
  else{
    double x = event.getX();
    if(lp_x-x>0)
      rot_y+=event.getCount();
    else
      rot_y-=event.getCount();
    lp_x = x;
  }
}

void keyPressed(KeyEvent event) {
  
  char key_value = event.getKey();
  
  if(key_value=='r'){
    point[0] = random((float)interval)+varMin;
    point[1] = random((float)interval)+varMin;
  }
  optimizer.adjust(key_value);
}

//==================================================================
//Coordinate system

public class LineCoordinateSystem implements ICoordinateSystem{
  public void drawCoordinateSystem(){
      drawArrow(0,0,0,width,0,2);
      drawArrow(0,0,0,height,90,2);
      drawArrow(0,0,0,width,-90,1);
      
      //drawArrow(0,0,0,width,-90,2);
      //drawArrow(0,0,0,width,180,2);
      //drawArrow(0,0,0,width,90,1);
  }
  
  private void drawArrow(double px, double py, double pz, int len, double angle,int rotAxis){
    pushMatrix();
    switch(rotAxis){
      case 0:
          rotateX(radians((float)angle));
        break;
      case 1:
          rotateY(radians((float)angle));
        break;
       case 2:
          rotateZ(radians((float)angle));
         break;
    }
    line((float)px, (float)py, (float)pz, (float)px+len, (float)py, (float)pz);
    line((float)px+len, (float)py, (float)pz, (float)px+len - 8, (float)py-8, (float)pz);
    line((float)px+len, (float)py, (float)pz, (float)px+len - 8, (float)py+8, (float)pz);
    popMatrix();
  }
}

public class BoxCoordinateSystem implements ICoordinateSystem{
  
  public void drawCoordinateSystem(){
    drawWall1();
    drawWall2();
    drawFloor();
  }
  
  private void drawWall1(){
    double pz = 0;
    for (double y= varMin; y<=varMax; y+=step) {
      double py = scaleYToPy(y);
      double py_last = py;
      double px_last = 0;
      //
      for (double x = varMin; x<=varMax; x+=step) {
        double px = scaleXToPx(x);
        line((float)px_last, (float)py_last, (float)pz, (float)px, (float)py, (float)pz);
        px_last = px;
      }
      py_last = py;
    }
    //
    for (double x = varMin; x<=varMax; x+=step) {
      double px = scaleXToPx(x);
      double px_last = px;
      double py_last = 0;
      //
      for (double y= varMin; y<=varMax; y+=step) {
        double py =scaleYToPy(y);
        line((float)px_last, (float)py_last, (float)pz, (float)px, (float)py, (float)pz);
        py_last = py;
      }
      px_last = px;
    }
  }

  private void drawWall2(){
    double px = 0;
    
    for (double y= varMin; y<=varMax; y+=step) {
      double py = scaleYToPy(y);
      double py_last = py;
      double pz_last = 0;
      //
      for (double z = varMin; z<=varMax; z+=step) {
        double pz = scaleZToPz(z);
        line((float)px, (float)py_last, (float)pz_last, (float)px, (float)py, (float)pz);
        pz_last = pz;
      }
      py_last = py;
    }
    //
    for (double z = varMin; z<=varMax; z+=step) {
      double pz = scaleZToPz(z);
      double pz_last = pz;
      double py_last = 0;
      //
      for (double y= varMin; y<=varMax; y+=step) {
        double py = scaleYToPy(y);
        line((float)px, (float)py_last, (float)pz_last, (float)px, (float)py, (float)pz);
        py_last = py;
      }
      pz_last = pz;
    }
  }

  private void drawFloor(){
    double py = height*1/10;
    for (double z= varMin; z<=varMax; z+=step) {
      double pz = scaleZToPz(z);
      double pz_last = pz;
      double px_last = 0;
      //
      for (double x = varMin; x<=varMax; x+=step) {
        double px = scaleXToPx(x);
        line((float)px_last, (float)py, (float)pz_last, (float)px, (float)py, (float)pz);
        px_last = px;
      }
      pz_last = pz;
    }
    //
    for (double x = varMin; x<=varMax; x+=step) {
      double px = scaleXToPx(x);
      double px_last = px;
      double pz_last = 0;
      //
      for (double z= varMin; z<=varMax; z+=step) {
        double pz = scaleZToPz(z);
        line((float)px_last, (float)py, (float)pz_last, (float)px, (float)py, (float)pz);
        pz_last = pz;
      }
      px_last = px;
    }
  }

}