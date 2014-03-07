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
 *************************************************************************/
 
import SimpleOpenNI.*;
import processing.opengl.*;
import oscP5.*;
import netP5.*;

SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);

PVector      com = new PVector(); //CENTER OF MASS
                                   
float scrx;

ArrayList<User> users = new ArrayList<User>();

//OSC stuff
OscP5 oscP5;
NetAddress sendLocation;
                                   
void setup(){
  size(1024,768,OPENGL);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;
  }

  // disable mirror
  context.setMirror(true);

  // enable depthMap generation
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser();

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
  // update the cam
  context.update();

  background(0,0,0);
  
  pushMatrix();
  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  int[]   depthMap = context.depthMap();
  int[]   userMap = context.userMap();
  int     steps   = 3;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
 
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera

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
  
  //loop through the users and do all updates here
  for(int i=0;i<users.size();i++){
    // draw the center of mass
    if(context.getCoM(users.get(i).userId,users.get(i).pos)){
      users.get(i).updateUser();
      User currUser = users.get(i);
      currUser.drawPos();
      
      scrx = screenX(currUser.pos.x,currUser.pos.y,currUser.pos.z);
    }
  }
  
  // draw the kinect cam
  context.drawCamFrustum();
  popMatrix();
  
  
  
  //draw the fading box to see movement tracking
  stroke(255,0,0);
  beginShape();
  fill(255,0);
  vertex(0,0);
  /*
  if user, add vertex where they are for fading color
  TOP VERTEX
  */
  for(int i=0;i<users.size();i++){
    if(context.getCoM(users.get(i).userId,com)){
      fill(255,0,255,50);
      vertex(scrx,0);
    }
  }
  fill(255,0);
  vertex(width,0);
  vertex(width,height);
  /*
  if user, add vertex where they are for fading color
  BOTTOM VERTEX
  */
  for(int i=0;i<users.size();i++){
    if(context.getCoM(users.get(i).userId,com)){
      fill(255,0,255,50);
      vertex(scrx,height);
    }
  }
  fill(255,0);
  vertex(0,height);
  endShape(CLOSE);
  ////////////////////////////////////////////////////
  
  //now send the scrx number to maxmsp
  float panValue = map(scrx,0,width,0,1); //get the pan in a percentage
  if(panValue >= 0.8) panValue = 1; //cap upper limit
  if(panValue <= 0.2) panValue = 0; //cap lower limit
  float rightPan = round(panValue * 100)/100.0;
  float leftPan = round((1-panValue)*100)/100.0;
  //println("rightPan = " + rightPan + " and leftPan = " + leftPan);
  OscMessage myMessage = new OscMessage("");
  myMessage.add(leftPan);
  myMessage.add(rightPan);
  oscP5.send(myMessage,sendLocation);  
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
// Keyboard events

void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
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
