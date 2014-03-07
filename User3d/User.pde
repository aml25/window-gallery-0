class User{

  int userId;
  PVector pos;
  PVector prevPos;
  float zZero;
  int[] rgb = new int[3];
  
  //the following are for keeping track of our running average "basePos" PVector
  ArrayList<Float> basePosX = new ArrayList<Float>();
  ArrayList<Float> basePosY = new ArrayList<Float>();
  ArrayList<Float> basePosZ = new ArrayList<Float>();
  int maxAvgCount = 200; //in a sense, this controls the "speed" of the interaction by setting
                         //how many past values should be stored to calculate the moving average
  
  PVector basePos; //this is the relative (running) base position that we compare all movement against
                   //it will be a running average of all previous and current positions
                   //weighting in forward (or reverse) order to come...
  
  long currMillis;
  
  //position updater counter
  long posMillisCount = 0;
  int posMillisCountInterval = 250; //1/4 of a second
  
  User(int id){
    userId = id;    
    pos = new PVector(); //create an empty PVector
    prevPos = new PVector(); //empty PVector to avoid NullPointer
    basePos = new PVector();
    
    for(int i=0;i<3;i++){
      rgb[i] = round(random(75,255));  
    }
  }
  
  void updateUser(){
    updatePos();
    drawPos();
    updateBasePos();
    drawBasePos();
    
    println("diff X = " + returnPosCoordDiff(pos.x,basePos.x));
    println("diff Y = " + returnPosCoordDiff(pos.y,basePos.y));
    println("diff Z = " + returnPosCoordDiff(pos.z,basePos.z));
  }
  
  void updatePos(){
    currMillis = millis();
    if(currMillis - posMillisCount > posMillisCountInterval){
      posMillisCount = currMillis;
      prevPos.set(pos); //store the last known center position ( USE SET() HERE NOT = )
    }
  }
  
  void updateBasePos(){
    basePosX.add(pos.x);
    basePosY.add(pos.y);
    basePosZ.add(pos.z);
    if(basePosX.size() > maxAvgCount){
      basePosX.remove(0);
      basePosY.remove(0);
      basePosZ.remove(0);
    }
    basePos.set(returnAvg(basePosX),returnAvg(basePosY),returnAvg(basePosZ));
  }
  
  float returnAvg(float[] v){
    float avg = 0;
    float weightSum = 0;
    for(int i=0;i<v.length;i++){
      float weight = (i+1.0)/v.length;
      avg += v[i]*weight;
      weightSum += weight;
    }
    return avg/weightSum;
  }
  
  float returnAvg(ArrayList<Float> v){
    float avg = 0;
    float weightSum = 0;
    for(int i=0;i<v.size();i++){
      float weight = (i+1.0)/v.size();
      avg += v.get(i)*weight;
      weightSum += weight;
    }
    return avg/weightSum;
  }
  
  void drawPos(){
    fill(rgb[0],rgb[1],rgb[2]);
    noStroke();
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    sphere(25);
    popMatrix();
  }
  
  void drawBasePos(){
    fill(rgb[0],rgb[1],rgb[2]);
    noStroke();
    pushMatrix();
    translate(basePos.x,basePos.y,basePos.z);
    sphere(10);
    popMatrix();  
  }
  
  float returnPosCoordDiff(float posVal, float basePosVal){
    return posVal - basePosVal;  
  }
  
  float returnPosDiff(PVector pos1, PVector pos2){
    float diff = 0;
    if(pos1 != null && pos2 != null){
      diff += abs(pos1.x - pos2.x);
      diff += abs(pos1.y - pos2.y);
      diff += abs(pos1.z - pos2.z);
      return diff/3;
    }
    else{
      return 0;  
    }
  }
  
}
