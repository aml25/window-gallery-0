import SimpleOpenNI.*;
import oscP5.*;
import netP5.*;

/* TO DO:

set the loopIndex when we load from JSON

*/

UserTracking userTracking;
int userIndexForSettingLoops = 0;

int loopIndex = 0;

ArrayList<Loop> loops = new ArrayList<Loop>();

//cam
float zoomF =0.5f;
float rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float rotY = radians(0);

//OSC stuff
OscP5 oscP5;
NetAddress sendLocation;

void setup(){
  size(1024,768,P3D); 
  smooth();
  
  loadLoops();
  userTracking = new UserTracking(this);
  
  oscP5 = new OscP5(this,6000);
  sendLocation = new NetAddress("127.0.0.1",6100);
}

void draw(){
  background(0);
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
  
  println("sending loop data");
  OscMessage myMessage = new OscMessage("");
  for(int i=0;i<loops.size();i++){
    myMessage.add(int(loops.get(i).userInside));
  }
  oscP5.send(myMessage, sendLocation);
  println("-----------------");
}


//This is for adding loops from calibration, the assumption here is that only 1 user is in view
void mousePressed(){
  for(int i=0;i<userTracking.userCenters.size();i++){
    if(userTracking.userCenters.get(i).z < 0 || userTracking.userCenters.get(i).z > 0){
      userIndexForSettingLoops = i;
      break;
    }  
  }
  
  //create a new loop
  if(userTracking.userCenters.size() > 0){
    loops.add(new Loop(loopIndex,userTracking.userCenters.get(userIndexForSettingLoops).get()));
    println("adding new loop location");
  }
  else{
    println("no user in sight");
  }
}

void mouseReleased(){
  if(loops.size() > loopIndex){ //have we added a new loop but haven't finished creating it?
    float myRadius = 0;
    if(userTracking.userCenters.size() > 0){ //user still in sight?  if so, set the radius
      myRadius = PVector.dist(loops.get(loopIndex).loc, userTracking.userCenters.get(userIndexForSettingLoops));
    }
    else{
      myRadius = 600; //default
    }
    loops.get(loopIndex).setRadius(myRadius); //set the radius
    loopIndex++; //increment the loop counter
    saveLoops();
  }
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
  }
  catch(Exception e){
    e.printStackTrace();  
  }
}

void saveLoops(){
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
}
