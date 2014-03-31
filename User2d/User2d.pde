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
 
/**************************************
TO DO:
* 
**************************************/

import SimpleOpenNI.*;
import oscP5.*;
import netP5.*;

SimpleOpenNI  context;

ArrayList<User> users = new ArrayList<User>();
ArrayList<Zone> zones = new ArrayList<Zone>();

//OSC stuff
OscP5 oscP5;
NetAddress sendLocation;

void setup()
{
  size(640,480);
  frameRate(24);
  
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  context.setMirror(false);
  context.enableDepth(); // enable depthMap generation 
  context.enableUser(); // enable skeleton generation for all joints
  smooth();
  
  oscP5 = new OscP5(this,6000);
  sendLocation = new NetAddress("127.0.0.1",6100);
  
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
  
  //int[] userList = context.getUsers();
  for(int i=0;i<users.size();i++)
  {
    // draw the center of mass
    PVector com = new PVector();
    if(context.getCoM(users.get(i).userId,com)) //boolean to test the ID is still a User, 
                                                //also sets the "com" PVector with the Center of Mass
    {
      PVector com2d = new PVector();
      context.convertRealWorldToProjective(com,com2d);
      users.get(i).updateUser(com2d);
    }
  }
  
  //draw the zones
  for(int i=0;i<zones.size();i++){
    zones.get(i).updateZone(users);
  }
  
  //OSC stuff
  if(users.size() > 0){
    OscMessage myMessage = new OscMessage("");
    myMessage.add(zones.get(2).locationFactor); //volume
    myMessage.add(map(zones.get(2).deltaFactor,-width/3,width/3,-8,8)); //speed/direction
    //println(myMessage);
    oscP5.send(myMessage,sendLocation);
  }
}

// -----------------------------------------------------------------
// SimpleOpenNI events
void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  //curContext.startTrackingSkeleton(userId);
  users.add(new User(userId));
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
  users.remove(returnUserByUserId(userId));
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

// ----------------------------------------------------------------
// Extra functions
User returnUserByUserId(int id){
  for(int i=0;i<users.size();i++){
    if(users.get(i).userId == id){
      return users.get(i);
    }
  }
  
  return null;
}

float smoothVal(float x, float y){
  float diff = abs(x - y) / 20;
  return x >= y ? x-diff : x + diff;  
}
