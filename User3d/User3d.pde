/* --------------------------------------------------------------------------
 * SimpleOpenNI User3d Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */
 
 /*************************************************************************
 To Do:
 ---- Fix the CENTERED user.pos bug, figure out a way to drop them (0.0,0.0,0.0)
 ---- Figure out a way to clean up users that are not real users 
 *************************************************************************/
 
import SimpleOpenNI.*;
import processing.opengl.*;
import oscP5.*;
import netP5.*;

//SimpleOpenNI context;
DepthCam depthCam;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);
PVector      com = new PVector(); //CENTER OF MASS

float[] xMinMax = { -5,5 };

float scrx;

ArrayList<User> users = new ArrayList<User>();

//OSC stuff
OscP5 oscP5;
NetAddress sendLocation;
                                   
void setup(){
  size(1024,768,OPENGL);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  
  depthCam = new DepthCam(this);
  
  stroke(255,255,255);
  smooth();  
  perspective(radians(45),
              float(width)/float(height),
              10,150000);
              
  oscP5 = new OscP5(this,6000);
  sendLocation = new NetAddress("127.0.0.1",6100);
}

void draw()
{
  

  background(0,0,0);
  depthCam.updateDepthCam(); //this starts the matrix (pushMatrix())
  
  
  //loop through the users and do all updates here
  for(int i=0;i<users.size();i++){
    // draw the center of mass
    PVector myPos = depthCam.checkCoM(users.get(i).userId);
    if(myPos != null){
      users.get(i).updateUser(myPos);
        
      //scrx = screenX(users.get(i).pos.x,users.get(i).pos.y,users.get(i).pos.z);
    }
    else{
      users.get(i).updateUser();
    }
  }
  
  depthCam.drawCamFrustrum(); //this ends the matrix (popMatrix())
  
  //now send to maxmsp
  /*float panValue = map(scrx,0,width,0,1); //get the pan in a percentage
  if(panValue >= 0.8) panValue = 1; //cap upper limit
  if(panValue <= 0.2) panValue = 0; //cap lower limit
  float rightPan = round(panValue * 100)/100.0;
  float leftPan = round((1-panValue)*100)/100.0;
  //println("rightPan = " + rightPan + " and leftPan = " + leftPan);*/
  if(users.size() > 0){
    PVector diff = users.get(0).posDiff;
    OscMessage myMessage = new OscMessage("");
    float x = map(diff.x,-150,150,xMinMax[0],xMinMax[1]); //NEEDS WORK
    x = x > xMinMax[1] ? xMinMax[1] : x;
    x = x < xMinMax[0] ? xMinMax[0] : x;
    myMessage.add(x);
    myMessage.add(diff.z);
    //println(myMessage);
    oscP5.send(myMessage,sendLocation);
  }
}

//User functions----------------------------------------------------
User returnUserByUserId(int id){
  for(int i=0;i<users.size();i++){
    if(users.get(i).userId == id){
      return users.get(i);
    }
  }
  
  return null;
}
////////////////////////////////////////////////////////////////////

// -----------------------------------------------------------------
// SimpleOpenNI user events
void onNewUser(SimpleOpenNI curContext,int userId)
{
  println("onNewUser - userId: " + userId);
  //context.startTrackingSkeleton(userId);
  users.add(new User(userId));
}

void onLostUser(SimpleOpenNI curContext,int userId) //this is called 10 seconds after the user is lost
{
  println("onLostUser - userId: " + userId);
  users.remove(returnUserByUserId(userId));
}

void onVisibleUser(SimpleOpenNI curContext,int userId)
{
  //println("on visible user");
}

// -----------------------------------------------------------------
// Mouse events
void mousePressed(){
  users.add(new User(int(random(10,500))));
  PVector newPos = new PVector(0,0,0);
  users.get(users.size()-1).updateUser(newPos);
}

// -----------------------------------------------------------------
// Keyboard events

void keyPressed()
{
  switch(key)
  {
  case ' ':
    depthCam.setMirror();
    break;
  }
    
  switch(keyCode)
  {
    case LEFT:
      rotY += 0.1f;
      break;
    case RIGHT:
      // zoom out
      rotY -= 0.1f;
      break;
    case UP:
      if(keyEvent.isShiftDown())
        zoomF += 0.01f;
      else
        rotX += 0.1f;
      break;
    case DOWN:
      if(keyEvent.isShiftDown())
      {
        zoomF -= 0.01f;
        if(zoomF < 0.01)
          zoomF = 0.01;
      }
      else
        rotX -= 0.1f;
      break;
  }
}

float smoothVal(float x, float y){
  float diff = abs(x - y) / 20;
  return x >= y ? x-diff : x + diff;  
}
