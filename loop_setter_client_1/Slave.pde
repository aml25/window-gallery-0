class Slave {

  Client c;
  String input;
  String output;
  boolean connected = false;
  int port = 9000;
  int id;
  
  /*float rotY = 0;
  float rotX = 0;
  float zoomF = 0;*/
  
  Slave(int i,PApplet p){
    //size(640,480);
    id = i;
    while(!connected){
      try{
        c = new Client(p, "127.0.0.1", port);
        println(c.ip());
        connected = true;
      }
      catch(Exception e){
        delay(1000); //wait 1 second
        println("waiting for server to start");
      }
    }
  }
  
  void updateSlave(){
    //receive from server
    if(c.available() > 0){
      input = c.readString();
      input = input.substring(0, input.indexOf("\n")); //only up to the new line
      println("from server: " + input);
      String func = split(input,"*")[0];
      if(func.equals("initiateLoopSet")){
        println("grabbing location");
        initiateLoopSet();
      }
      else if(func.equals("finishLoopSet")){
        println("finishing the loop creation");
        finishLoopSet();
      }
      else if(func.equals("rotateY")){
        rotY += float(split(input,"*")[1]); //var from the main sketch
        println("rotY = " + rotY);
      }
      else if(func.equals("rotateX")){
        rotX += float(split(input,"*")[1]); //var from the main sketch
        println("rotX = " + rotX);
      }
      else if(func.equals("zoomF")){
        zoomF += float(split(input,"*")[1]); //var from the main sketch
        println("zoomF = " + zoomF);
      }
    }
  }
  
  void initiateLoopSet(){
    //if(calibrationMode){ //only add loops if we are currently in calibration mode
      for(int i=0;i<userTracking.userCenters.size();i++){
        if(userTracking.userCenters.get(i).z < 0 || userTracking.userCenters.get(i).z > 0){ //make sure the user we are 
                                                                                            //tracking is actually an
                                                                                            //active user
          userIndexForSettingLoops = i;
          break;
        }
        else{
          userIndexForSettingLoops = -1;  
        }
      }
      
      //create a new loop
      if(userIndexForSettingLoops != -1){
        loops.add(new Loop(loopIndex,userTracking.userCenters.get(userIndexForSettingLoops).get()));
        println("adding new loop location");
      }
      else{
        println("no user in sight");
      }
    //}
  }
  
  void finishLoopSet(){
    if(userIndexForSettingLoops != -1){
      println("setting radius size");
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
        println("saving loops");
      }
    }
  }
  
  void saveLoops(){ //send it over to the master
    Loop l = loops.get(loops.size()-1);
    output = "saveLoop*" + id + "*" + l.loc.x + "*" + l.loc.y + "*" + l.loc.z + "*" +
             l.index + "*" + l.radius + "\n";
    delay(id*200);
    c.write(output);
  }
}
