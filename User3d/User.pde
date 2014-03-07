class User{

  int userId;
  PVector pos;
  PVector prevPos;
  float zZero;
  int[] rgb = new int[3];
  
  long currMillis;
  
  //position updater counter
  long posMillisCount = 0;
  int posMillisCountInterval = 250; //1/4 of a second
  
  User(int id){
    userId = id;    
    pos = new PVector(); //create an empty PVector
    prevPos = new PVector(); //empty PVector to avoid NullPointer
    
    for(int i=0;i<3;i++){
      rgb[i] = round(random(75,255));  
    }
  }
  
  void updateUser(){
    updatePos();
  }
  
  void updatePos(){
    currMillis = millis();
    if(currMillis - posMillisCount > posMillisCountInterval){
      posMillisCount = currMillis;
      prevPos.set(pos); //store the last known center position ( USE SET() HERE NOT = )
    }
    println(returnPosDiff());
  }
  
  void drawPos(){
    fill(rgb[0],rgb[1],rgb[2]);
    noStroke();
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    sphere(25);
    popMatrix();
  }
  
  float returnPosDiff(){
    float diff = 0;
    if(pos != null && prevPos != null){
      diff += abs(pos.x - prevPos.x);
      diff += abs(pos.y - prevPos.y);
      diff += abs(pos.z - prevPos.z);
      return diff/3;
    }
    else{
      return 0;  
    }
  }
  
}
