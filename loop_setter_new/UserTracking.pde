class UserTracking{

  SimpleOpenNI  context;  
  color[] userClr = new color[]{ color(255,0,0),
                                 color(0,255,0),
                                 color(0,0,255),
                                 color(255,255,0),
                                 color(255,0,255),
                                 color(0,255,255) };
  PVector com = new PVector();                                   
  PVector com2d = new PVector();

  ArrayList<PVector> userCenters = new ArrayList<PVector>();  
  
  UserTracking(PApplet p){
    context = new SimpleOpenNI(p);
    if(context.isInit() == false){
       println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
       exit();
       return;  
    }
    
    context.setMirror(true);
    
    // enable depthMap generation 
    context.enableDepth();
     
    // enable skeleton generation for all joints
    context.enableUser();
    
    //added for 3d
    stroke(255,255,255);
    smooth();  
    perspective(radians(45),
                float(width)/float(height),
                10,150000);
  }
  
  void drawUsers()
  {
    ArrayList<PVector> centers = new ArrayList<PVector>();
        
    // update the cam
    context.update(); 
    
    int[]   depthMap = context.depthMap();
    int[]   userMap = context.userMap();
    int     steps   = 3;  // to speed up the drawing, draw every third point
    int     index;
    PVector realWorldPoint;
  
    // draw the pointcloud
    beginShape(POINTS);
    for(int y=0;y < context.depthHeight();y+=steps)
    {
      for(int x=0;x < context.depthWidth();x+=steps)
      {
        index = x + y * context.depthWidth();
        if(depthMap[index] > 0)
        { 
          // draw the projected point
          realWorldPoint = context.depthMapRealWorld()[index];
          if(userMap[index] == 0)
            stroke(100); 
          else
            stroke(userClr[ (userMap[index] - 1) % userClr.length ]);        
          
          point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
        }
      } 
    } 
    endShape();
    
    int[] userList = context.getUsers();
    for(int i=0;i<userList.length;i++){
      // draw the center of mass
      if(context.getCoM(userList[i],com))
      {
        stroke(100,255,0);
        strokeWeight(1);
        beginShape(LINES);
          vertex(com.x - 15,com.y,com.z);
          vertex(com.x + 15,com.y,com.z);
          
          vertex(com.x,com.y - 15,com.z);
          vertex(com.x,com.y + 15,com.z);
  
          vertex(com.x,com.y,com.z - 15);
          vertex(com.x,com.y,com.z + 15);
        endShape();
        
        fill(0,255,100);
        text(Integer.toString(userList[i]),com.x,com.y,com.z);
        
        centers.add(com.get());
      }
    }
    userCenters = centers;
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
