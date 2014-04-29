class DepthCam{

  SimpleOpenNI  context;  
  int[] userClr = new int[]{ color(255,0,0),
                                 color(0,255,0),
                                 color(0,0,255),
                                 color(255,255,0),
                                 color(255,0,255),
                                 color(0,255,255) };
  PVector com = new PVector();                                   
  PVector com2d = new PVector();
  
  //cam
  float zoomF =0.3f;
  float rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                     // the data from openni comes upside down
  float rotY = radians(0);

  ArrayList<PVector> userCenters = new ArrayList<PVector>();
  PGraphics pg;
  
  DepthCam(int index, PApplet p){
    context = new SimpleOpenNI(index,p);
    if(context.isInit() == false){
       println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
       exit();
       return;  
    }
    
    context.setMirror(false);
    
    // enable depthMap generation 
    context.enableDepth();
    
    // enable skeleton generation for all joints
    context.enableUser();
    context.enableRGB();
    
    pg = createGraphics(640,480,P3D);
    
    //added for 3d
    stroke(255,255,255);
    smooth();  
    pg.perspective(radians(45),
                PApplet.parseFloat(pg.width)/PApplet.parseFloat(pg.height),
                10,150000);
  }
  
  PImage returnRGBImage(){
    return context.rgbImage();
  }
  
  PGraphics drawUsers()
  {
    pg.beginDraw();
    pg.background(0);
    pg.pushMatrix();
    // set the scene pos
    pg.translate(pg.width/2, pg.height/2, 0);
    pg.rotateX(rotX);
    pg.rotateY(rotY);
    pg.scale(zoomF);
    pg.translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera
    
    
    ArrayList<PVector> centers = new ArrayList<PVector>();
        
    // update the cam
    context.update(); 
    
    PImage rgbImage = context.rgbImage();
    int[]   depthMap = context.depthMap();
    int[]   userMap = context.userMap();
    int     steps   = 3;  // to speed up the drawing, draw every third point
    int     index;
    PVector realWorldPoint;
    //color pixelColor;
    
    PVector[] realWorldMap = context.depthMapRealWorld();
  
    // draw the pointcloud
    pg.beginShape(POINTS);
    for(int y=0;y < context.depthHeight();y+=steps)
    {
      for(int x=0;x < context.depthWidth();x+=steps)
      {
        index = x + y * context.depthWidth();
        if(depthMap[index] > 0)
        {
          //pixelColor = rgbImage.pixels[index];
          // draw the projected point
          realWorldPoint = realWorldMap[index];
          if(userMap[index] == 0){
            //stroke(100); 
            pg.stroke(255);
          }
          else{
            pg.stroke(userClr[ (userMap[index] - 1) % userClr.length ]);
          }
          
          pg.pushMatrix();
          pg.translate(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
          pg.box(4);
          pg.point(0,0,0);
          pg.popMatrix();
        }
      } 
    } 
    pg.endShape();
    
    int[] userList = context.getUsers();
    for(int i=0;i<userList.length;i++){
      // draw the center of mass
      if(context.getCoM(userList[i],com))
      {
        pg.stroke(100,255,0);
        pg.strokeWeight(1);
        pg.beginShape(LINES);
          pg.vertex(com.x - 15,com.y,com.z);
          pg.vertex(com.x + 15,com.y,com.z);
          
          pg.vertex(com.x,com.y - 15,com.z);
          pg.vertex(com.x,com.y + 15,com.z);
  
          pg.vertex(com.x,com.y,com.z - 15);
          pg.vertex(com.x,com.y,com.z + 15);
        pg.endShape();
        
        pg.fill(0,255,100);
        pg.text(Integer.toString(userList[i]),com.x,com.y,com.z);
        
        centers.add(com.get());
      }
    }
    userCenters = centers;
    
    pg.popMatrix();
    pg.endDraw();
    
    return pg;
  }
  
  // -----------------------------------------------------------------
  // SimpleOpenNI events
  
  void onNewUser(SimpleOpenNI curContext, int userId){
    println("onNewUser - userId: " + userId);
    println("\tstart tracking skeleton");
    
    curContext.startTrackingSkeleton(userId);
  }
  
  void onLostUser(SimpleOpenNI curContext, int userId){
    println("onLostUser - userId: " + userId);
  }
  
  void onVisibleUser(SimpleOpenNI curContext, int userId){
    //println("onVisibleUser - userId: " + userId);
  }
  
}

