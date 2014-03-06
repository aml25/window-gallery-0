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
  
  //kill checker counter
  long samePosMillisCount = 0;
  int samePosMillisCountInterval = 3000; //3 seconds
  boolean goodToKill = false;
  
  User(int id){
    userId = id;
    
    for(int i=0;i<3;i++){
      rgb[i] = round(random(75,255));  
    }
  }
  
  void updateUser(PVector p){
    updatePos(p);
    checkIfUserShouldBeKilled();
  }
  
  void updatePos(PVector p){
    currMillis = millis();
    if(currMillis - posMillisCount > posMillisCountInterval){
      posMillisCount = currMillis;
      prevPos = pos; //store the last known center position
    }
    pos = p; //update the center position
  }
  
  float returnPosDiff(){
    float diff = 0;
    diff += abs(pos.x - prevPos.x);
    diff += abs(pos.y - prevPos.y);
    diff += abs(pos.z - prevPos.z);
    return diff/3;
  }
  
  void checkIfUserShouldBeKilled(){
    currMillis = millis();
    if(pos != prevPos && !goodToKill){
      samePosMillisCount = currMillis; //reset the timer so that we never set the boolean flag to delete THIS
    }
    
    if(currMillis - samePosMillisCount > samePosMillisCountInterval){
      goodToKill = true; //flag THIS to be removed
      println("Killing user " + userId);
    }
  }
  
}
