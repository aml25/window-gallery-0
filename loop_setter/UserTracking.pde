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
    
    // enable depthMap generation 
    context.enableDepth();
     
    // enable skeleton generation for all joints
    context.enableUser();
  }
  
  void drawUsers()
  {
    ArrayList<PVector> centers = new ArrayList<PVector>();
        
    // update the cam
    context.update();
    
    // draw depthImageMap
    //image(context.depthImage(),0,0);
    image(context.userImage(),0,0);
    
    // draw the skeleton if it's available
    int[] userList = context.getUsers();
    for(int i=0;i<userList.length;i++){      
      // draw the center of mass
      if(context.getCoM(userList[i],com)){
        context.convertRealWorldToProjective(com,com2d);
        stroke(100,255,0);
        strokeWeight(1);
        beginShape(LINES);
          vertex(com2d.x,com2d.y - 5);
          vertex(com2d.x,com2d.y + 5);
  
          vertex(com2d.x - 5,com2d.y);
          vertex(com2d.x + 5,com2d.y);
        endShape();
        
        fill(0,255,100);
        text(Integer.toString(userList[i]),com2d.x,com2d.y);
        
        centers.add(com2d);
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
