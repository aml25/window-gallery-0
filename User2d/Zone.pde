class Zone{
  
  float x;
  float w;
  float[] c = new float[3];
  float centerLocX;
  int zoneId;
  float alph = 75;
  
  Zone(int id, float myX, float myW){
    zoneId = id;
    x = myX;
    w = myW;
    //println("x = " + x + " w = " + w);
    for(int i=0;i<3;i++){
      c[i] = random(50,255);
    }
    centerLocX = x+(w/2);
  }
  
  void updateZone(PVector userPos){
    alph = map(returnUserDistances(centerLocX, userPos.x),0,width/2,255,0);
    drawZone();
  }
  
  void drawZone(){
    rectMode(CORNER);
    fill(c[0],c[1],c[2],alph);
    noStroke();
    rect(x,0,w,height);
  }
  
  /*void getUserDistances(ArrayList<User> users){
    float[] d = new float[users.size()];
    
    for(int i=0;i<d.length;i++){
      d[i] = abs(centerLoc - users.get(i).pos.x);
    }
    
    distances = d;
    if(distances.length > 0)
      alph = map(distances[0],0,width/2,255,0);
    //println("zone" + zoneId + " distances = ");
    //println(distances);
  }*/
  
  float returnUserDistances(float pos1, float pos2){
    float distance = 0;
    //for(int i=0;i<d.length;i++){
    distance = abs(pos1 - pos2);
    //}

    return distance;
  }
  
}
