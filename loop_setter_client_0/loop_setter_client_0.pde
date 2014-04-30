import SimpleOpenNI.*;
import oscP5.*;
import netP5.*;
import processing.net.*;

/*
  Keypresses
  e = empty (clear the loops data)
  c = calibration (toggle calibration mode)
*/

UserTracking userTracking;
int userIndexForSettingLoops = -1;
int id = 0;

int loopIndex = 0;

ArrayList<Loop> loops = new ArrayList<Loop>();

//cam
float zoomF =0.2f;
float rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float rotY = radians(0);

//boolean calibrationMode = false;

CameraWindow cameraWindow;

Slave slave;

//OSC stuff
OscP5 oscP5;
NetAddress sendLocation;

void setup(){
  size(640,480,P3D); 
  smooth();
  
  slave = new Slave(id,this);
  
  cameraWindow = new CameraWindow();
  
  loadLoops();
  userTracking = new UserTracking(id,this);
  
  oscP5 = new OscP5(this,6000);
  sendLocation = new NetAddress("127.0.0.1",6100);
}

void draw(){
  background(0);
  
  slave.updateSlave();
  
  //image(cameraWindow.drawCameraWindow(userTracking.returnRGBImage()),0,0);
  //cameraWindow.drawCameraWindow(userTracking.returnRGBImage());
  
  pushMatrix();
  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera
  
  userTracking.drawUsers();
  
  //draw the loops being passed from the main sketch
  for(int i=0;i<loops.size();i++){
    loops.get(i).checkIfUserInside(userTracking.userCenters);
    loops.get(i).drawLoop();
  }
  
  popMatrix();
  
  //println("sending loop data");
  OscMessage myMessage = new OscMessage("");
  for(int i=0;i<loops.size();i++){
    myMessage.add(int(loops.get(i).userInside));
  }
  oscP5.send(myMessage, sendLocation);
  //println("-----------------");
  
  
  //save frames if user is in site
  /*for(int i=0;i<userTracking.userCenters.size();i++){
    if(userTracking.userCenters.get(i).z < 0 || userTracking.userCenters.get(i).z > 0){
      thread("saveCameraFrame");
      break;
    }
  }*/
}

//to be called from a thread
void saveCameraFrame(){
  cameraWindow.pg.save("data/frame-"+cameraWindow.frameCounter+".png");
  cameraWindow.frameCounter++;
}

/*void keyPressed(){
  if(key == 'c'){
    calibrationMode = !calibrationMode;
    println("calibration mode? " + calibrationMode);
  } 
  else if(key == 'e'){
    loops.clear();
    saveLoops();
    calibrationMode = true;
    println("clearing loops data");
    println("calibration mode? " + calibrationMode);
  }
}*/


//This is for adding loops from calibration, the assumption here is that only 1 user is in view
void mousePressed(){
  
}

void mouseReleased(){ //potential bug here to fix, if we lost a user while mousePressed, and it comes back
                      //for the mouseReleased with a different index, it will crash or not function propery
  
}



void loadLoops(){
  try{
    JSONArray loadedLoops = loadJSONArray("loops.json");
    for(int i=0;i<loadedLoops.size();i++){
      //println(loadedLoops.getJSONObject(i));
      JSONObject loop = loadedLoops.getJSONObject(i);
      PVector loadedLoc = new PVector(loop.getFloat("x"),loop.getFloat("y"),loop.getFloat("z"));
      loops.add(new Loop(loop.getInt("index"),loadedLoc));
      loops.get(loops.size()-1).setRadius(loop.getFloat("radius"));
    }
    
    loopIndex = loops.size(); //the length will be 1+ the index of the last 
  }
  catch(Exception e){
    e.printStackTrace();  
  }
}

/*void saveLoops(){
  JSONArray myLoops = new JSONArray();
  for(int i=0;i<loops.size();i++){
    JSONObject loop = new JSONObject();
    loop.setFloat("x",loops.get(i).loc.x);
    loop.setFloat("y",loops.get(i).loc.y);
    loop.setFloat("z",loops.get(i).loc.z);
    loop.setInt("index",loops.get(i).index);
    loop.setFloat("radius",loops.get(i).radius);
    myLoops.append(loop);
  }
  
  saveJSONArray(myLoops,"data/loops.json");
}*/
