/*creating, saving loop centerpoints
**and determining user(s) distance(s) from those points
*/

import SimpleOpenNI.*;

int loopIndex = 0;
ArrayList<Loop> loops = new ArrayList<Loop>();

UserTracking userTracking;

void setup(){
  size(640,480);
  smooth();
  
  userTracking = new UserTracking(this);
  
  loadLoops();
}

void draw(){
  background(0);
  
  userTracking.drawUsers();
  
  fill(255);
  noStroke();
  for(int i=0;i<loops.size();i++){
    loops.get(i).drawLoop();
  }
  
  //calculate the distance between users and loops
  for(int i=0;i<loops.size();i++){
    loops.get(i).clearClosestBools();
    for(int u=0;u<userTracking.userCenters.size();u++){
      loops.get(i).addClosestBool(returnClosestLoopIndex(userTracking.userCenters.get(u)) == i);
    }
  }
  
  
  println("sending loop data");
  for(int i=0;i<loops.size();i++){
    loops.get(i).figureOutIfClosest();
    println("loop " + i + " closest = " + loops.get(i).isAClosestLoop);
  }
  println("-----------------");
}

int returnClosestLoopIndex(PVector userCenter){
  float d = -1;
  int index = -1;
  for(int i=0;i<loops.size();i++){
    float currDistance = PVector.dist(userCenter,loops.get(i).loc);
    if(currDistance <= d || d == -1){
      d = currDistance;
      index = i;
    }
  }
  return index;
}

void keyPressed(){
  int index = int(key+"");
  //selectedLoopIndex = index;
  
}

void mousePressed(){
  //create a new loop
  if(userTracking.userCenters.size() > 0){
    loops.add(new Loop(loopIndex,userTracking.userCenters.get(0).get()));
    loopIndex++;
    println("adding new loop location");
    
    saveLoops();
  }
  else{
    println("no user in sight");
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
    myLoops.append(loop);
  }
  
  saveJSONArray(myLoops,"data/loops.json");
}
