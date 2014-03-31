class Zone{
  
  float x;
  float w;
  float[] c = new float[3];
  float centerLocX;
  int zoneId;
  float alph = 75;
  float locationFactor = 0;
  float deltaFactor = 0;
  
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
  
  /*void updateZone(PVector userPos){
    alph = map(returnUserDistances(centerLocX, userPos.x),0,width/2,255,0);
    drawZone();
  }*/
  
  void updateZone(ArrayList<User> u){
    updateFactors(u);
    alph = map(locationFactor, 0, 1, 0,255);
    drawZone();
  }
  
  void updateFactors(ArrayList<User> u){
    float[] distances = returnUserDistances(u);
    locationFactor = 0;
    deltaFactor = 0;
    int numCountedUsers = 0;
    for(int i=0;i<distances.length;i++){ //same length as u.size()
      if(distances[i] < width/3){
        locationFactor += map(distances[i], 0, width/3, 1, 0);
        deltaFactor += users.get(i).returnPosDelta();
        numCountedUsers++;
      }
    }
    locationFactor = locationFactor >= 1 ? 1 : locationFactor;
    deltaFactor = numCountedUsers > 0 ? deltaFactor/numCountedUsers : 0;
  }
  
  void drawZone(){
    rectMode(CORNER);
    fill(c[0],c[1],c[2],alph);
    noStroke();
    rect(x,0,w,height);
  }
  
  float[] returnUserDistances(ArrayList<User> u){
    float[] d = new float[u.size()];
    for(int i=0;i<d.length;i++){
      d[i] = returnUserDistance(centerLocX,u.get(i).pos.x);  
    }

    return d;
  }
  
  float returnUserDistance(float pos1, float pos2){
    float distance = 0;
    //for(int i=0;i<d.length;i++){
    distance = abs(pos1 - pos2);
    //}

    return distance;
  }
  
}
