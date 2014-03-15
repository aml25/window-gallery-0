/* --------------------------------------------------------------------------
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;

SimpleOpenNI  context;

PVector com = new PVector();                                   
PVector com2d = new PVector();

ArrayList<Zone> zones = new ArrayList<Zone>();

void setup()
{
  size(640,480);
  
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  context.setMirror(true);
  // enable depthMap generation 
  context.enableDepth();
  // enable skeleton generation for all joints
  context.enableUser();
  smooth();
  
  constructZones(4);
}

void constructZones(int n){
  float w = width/n;
  for(int i=0;i<n;i++){
    zones.add(new Zone(i,(i*w),w));
  }
}

void draw()
{
  background(200,0,0);
  
  // update the cam
  context.update();
  
  // draw depthImageMap
  //image(context.depthImage(),0,0);
  image(context.userImage(),0,0);
  
  int[] userList = context.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    // draw the center of mass
    if(context.getCoM(userList[i],com))
    {
      context.convertRealWorldToProjective(com,com2d);
      fill(255);
      pushMatrix();
      translate(com2d.x,com2d.y);
      ellipse(0,0,25,25);
      popMatrix();
    }
  }
  
  //draw the zones
  for(int i=0;i<zones.size();i++){
    zones.get(i).updateZone(com2d);
  }
}
// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}  
