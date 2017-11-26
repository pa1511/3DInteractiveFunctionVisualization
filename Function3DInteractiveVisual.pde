//==================================================================
//Imports


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

  frame.setResizable(true);
}

//==================================================================
//Start point
float[] point = new float[2];

//==================================================================
//Current function

//EXAMPLE1
//IFunction fun = new Deceptive();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(4,10,-10,2,10);

//EXAMPLE2
IFunction fun = new MultyLocal();
IPlottingConfig plottingConfig = new SimplePlottingConfig(8,6,-6,2,10);

//EXAMPLE3
//IFunction fun = new Simple();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(4,10,-10,1,10);

//EXAMPLE4
//IFunction fun = new Sigmoid();
//IPlottingConfig plottingConfig = new SimplePlottingConfig(4,10,-10,1,10);r

//EXAMPLE5
//IFunction fun = new DerivativeFunctionWrapper(new Ackley());
//IPlottingConfig plottingConfig = new SimplePlottingConfig(20,3,-3,2,10);

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
                          //new MomentGradientDescent(0.05,new float[]{0.8,0.8});
                          //new ChangingLrGradientDescent(2,0.01,500);
                          //new NesterovMomentGradientDescent(2,0.8);
                          //new AdaGradGradientDescent(1);
                          //new RMSProp(1,0.4);
                          new AdamGradientDescent(2.5,0.9,0.999);
//==================================================================
//Plotting config
                                 
float point_density = plottingConfig.getPointDensity();
float varMin = plottingConfig.getVarMin();
float varMax = plottingConfig.getVarMax();
float interval = varMax-varMin;
float step = plottingConfig.getStep();
int ball_size = plottingConfig.getBallSize();

//
float scale = 0.5;
//
int rot_x = 180;
int rot_y = 180; 
//
float t_x = width;
float t_y = height/2;

ICoordinateSystem coordinateSystem = //new BoxCoordinateSystem();
                                     new LineCoordinateSystem();
//==================================================================
//Plotting

void draw() {
  
  //
  translate(width*2/3,height*7/10);
  //
  scale(scale);
  //
  translate(t_x,t_y,0);
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

  float fpStep = step/point_density;
  
  float fMin = fun.functionMin();
  float fInterval = fun.functionMax()-fun.functionMin();
  
  for (float z= varMin; z<=varMax; z+=fpStep) {
    float pz1 = scaleZToPz(z);
    float pz2 = scaleZToPz(z+fpStep);
    for (float x = varMin; x<=varMax; x+=fpStep) {
      float px1 = scaleXToPx(x);
      float px2 = scaleXToPx(x+fpStep);
     
      float y1 = fun.calculate(x,z);
      float y2 = fun.calculate(x+fpStep,z+fpStep);
      float y3 = fun.calculate(x+fpStep,z);
      float y4 = fun.calculate(x,z+fpStep);
      
      
      float py1 = scaleYToPy(y1);
      float py2 = scaleYToPy(y2);
      float py3 = scaleYToPy(y3);
      float py4 = scaleYToPy(y4);
    
      float yAvg = (y1+y2+y3+y4)/4.0;
    
      int r = (int)(255*(yAvg-fMin)/fInterval); 
    
      if(smood)
        noStroke();
        
      fill(r,255-r,0);
      
      beginShape(QUAD_STRIP);
      vertex(px1,py1,pz1);
      vertex(px2,py3,pz1);
      vertex(px1,py4,pz2);
      vertex(px2,py2,pz2);
      endShape(CLOSE);
      
    }
  }
  
}

void drawPoint(float x, float z){
  stroke(255,255,255);
  
  float px = scaleXToPx(x);
  float pz = scaleZToPz(z);
   
  float y = fun.calculate(x,z);
  float py = scaleYToPy(y); 
   
  translate(px, py+ball_size, pz);
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

private float scaleXToPx(float x){
  return width*(x-varMin)/interval;
}

private float scaleYToPy(float y){
  return height*(y-varMin)/interval;
}

private float scaleZToPz(float z){
  return width*(z-varMin)/interval;
}

//==================================================================
//interactions

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  float scaleChange = 0.01*e;
  scale -= scaleChange;
}

float ms_x = 0;
float ms_y = 0;

void mousePressed(MouseEvent event){
  int button = event.getButton();
  if(button==LEFT){
    ms_x = event.getX();
    ms_y = event.getY();
  }
}

float lp_x = 0;
float lp_y = 0;

void mouseDragged(MouseEvent event){
  int button = event.getButton();
  if(button==LEFT){
    t_x += (event.getX()-ms_x)/30;
    t_y += (event.getY()-ms_y)/30;
    // divided by 30 to reduce translation speed
  }
  else if(button==RIGHT){
    float y = event.getY();
    if(lp_y-y>0)
      rot_x+=event.getCount();
    else
      rot_x-=event.getCount();
    lp_y = y;
  }
  else{
    float x = event.getX();
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
    point[0] = random(interval)+varMin;
    point[1] = random(interval)+varMin;
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
  
  public void drawArrow(float px, float py, float pz, int len, float angle,int rotAxis){
    pushMatrix();
    switch(rotAxis){
      case 0:
          rotateX(radians(angle));
        break;
      case 1:
          rotateY(radians(angle));
        break;
       case 2:
          rotateZ(radians(angle));
         break;
    }
    line(px,py,pz,px+len, py,pz);
    line(px+len, py, pz ,px+len - 8, py-8, pz);
    line(px+len, py, pz, px+len - 8, py+8, pz);
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
    float pz = 0;
    for (float y= varMin; y<=varMax; y+=step) {
      float py = scaleYToPy(y);
      float py_last = py;
      float px_last = 0;
      //
      for (float x = varMin; x<=varMax; x+=step) {
        float px = scaleXToPx(x);
        line(px_last,py_last,pz,px,py,pz);
        px_last = px;
      }
      py_last = py;
    }
    //
    for (float x = varMin; x<=varMax; x+=step) {
      float px = scaleXToPx(x);
      float px_last = px;
      float py_last = 0;
      //
      for (float y= varMin; y<=varMax; y+=step) {
        float py =scaleYToPy(y);
        line(px_last,py_last,pz,px,py,pz);
        py_last = py;
      }
      px_last = px;
    }
  }

  private void drawWall2(){
    float px = 0;
    
    for (float y= varMin; y<=varMax; y+=step) {
      float py = scaleYToPy(y);
      float py_last = py;
      float pz_last = 0;
      //
      for (float z = varMin; z<=varMax; z+=step) {
        float pz = scaleZToPz(z);
        line(px,py_last,pz_last,px,py,pz);
        pz_last = pz;
      }
      py_last = py;
    }
    //
    for (float z = varMin; z<=varMax; z+=step) {
      float pz = scaleZToPz(z);
      float pz_last = pz;
      float py_last = 0;
      //
      for (float y= varMin; y<=varMax; y+=step) {
        float py = scaleYToPy(y);
        line(px,py_last,pz_last,px,py,pz);
        py_last = py;
      }
      pz_last = pz;
    }
  }

  private void drawFloor(){
    float py = height*1/10;
    for (float z= varMin; z<=varMax; z+=step) {
      float pz = scaleZToPz(z);
      float pz_last = pz;
      float px_last = 0;
      //
      for (float x = varMin; x<=varMax; x+=step) {
        float px = scaleXToPx(x);
        line(px_last,py,pz_last,px,py,pz);
        px_last = px;
      }
      pz_last = pz;
    }
    //
    for (float x = varMin; x<=varMax; x+=step) {
      float px = scaleXToPx(x);
      float px_last = px;
      float pz_last = 0;
      //
      for (float z= varMin; z<=varMax; z+=step) {
        float pz = scaleZToPz(z);
        line(px_last,py,pz_last,px,py,pz);
        pz_last = pz;
      }
      px_last = px;
    }
  }

}