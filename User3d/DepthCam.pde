class DepthCam{
  
  PApplet parent;
  SimpleOpenNI context;
  Boolean camExists; //used to know if we should enable manual tracking
  
  DepthCam(PApplet p){
    parent = p;
    
    context = new SimpleOpenNI(parent);
    
    if(cameraExists()){
      depthCamInit();
    }
  }
  
  void depthCamInit(){
    // disable mirror
    context.setMirror(true);
    // enable depthMap generation
    context.enableDepth();
    // enable skeleton generation for all joints
    context.enableUser();
  }

  boolean cameraExists(){
    if(camExists == null){
      camExists = context.isInit();
    }
    
    if(camExists == false){
      println("Camera is not connected, or there is another error");  
    }
    
    return camExists;
  }
  
  void updateDepthCam(){
    // update the cam
    context.update();
    
    drawPointCloud();
  }
  
  void drawPointCloud(){
    pushMatrix();
    // set the scene pos
    translate(width/2, height/2, 0);
    rotateX(rotX);
    rotateY(rotY);
    scale(zoomF);
    translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera
    if(camExists){
      int[]   depthMap = context.depthMap();
      int[]   userMap = context.userMap();
      int     steps   = 3;  // to speed up the drawing, draw every third point
      int     index;
      PVector realWorldPoint;
    
      // draw the pointcloud
      beginShape(POINTS);
      for(int y=0;y < context.depthHeight();y+=steps){
        for(int x=0;x < context.depthWidth();x+=steps){
          index = x + y * context.depthWidth();
          if(depthMap[index] > 0){ 
            // draw the projected point
            realWorldPoint = context.depthMapRealWorld()[index];
            if(userMap[index] != 0){
              User currUser = returnUserByUserId(userMap[index]);
              if(currUser != null){
                stroke(currUser.rgb[0],currUser.rgb[1],currUser.rgb[2]);
              }
              else{
                stroke(50,50,50);  
              }
            }
            else{
              stroke(50,50,50);  
            }
            point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
          }
        } 
      } 
      endShape();
    }
  }
  
  void drawCamFrustrum(){
    // draw the kinect cam
    //context.drawCamFrustum();
    popMatrix();
  }
  
  PVector checkCoM(int id){
    PVector pos = new PVector();
    if(context.getCoM(id,pos)){
      return pos;
    }
    else{
      return null;  
    }
  }
  
  void setMirror(){
    context.setMirror(!context.mirror());  
  }
  
}
