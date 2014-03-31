class User{
  
  int userId;
  PVector pos = new PVector();
  int[] rgb = new int[3];
  
  ArrayList<Float> coordsX = new ArrayList<Float>();
  ArrayList<Float> coordsY = new ArrayList<Float>();
  ArrayList<Float> coordsZ = new ArrayList<Float>();
  int maxBasePosTrackerCount = 250;
  PVector basePos = new PVector();
  
  User(int id){
    userId = id;
    for(int i=0;i<3;i++){
      rgb[i] = round(random(75,255));
    }      
  }
  
  void updateUser(PVector p){
    if(!Float.isNaN(p.x) && !Float.isNaN(p.y) && !Float.isNaN(p.z)){
      pos.add(p);
      pos.div(2);
      updateBasePos(pos);
      drawPos();
      drawBasePos();
    }
  }
  
  void drawPos(){
    pushMatrix();
    fill(rgb[0],rgb[1],rgb[2]);
    noStroke();
    translate(pos.x,pos.y);
    ellipse(0,0,25,25);
    popMatrix();  
  }
  
  void drawBasePos(){
    pushMatrix();
    fill(rgb[0],rgb[1],rgb[2]);
    noStroke();
    translate(basePos.x,basePos.y);
    ellipse(0,0,15,15);
    popMatrix();  
  }
  
  void updateBasePos(PVector myPos){
    coordsX.add(myPos.x);
    coordsY.add(myPos.y);
    coordsZ.add(myPos.z);
    if(coordsX.size() > maxBasePosTrackerCount){
      coordsX.remove(0);
      coordsY.remove(0);
      coordsZ.remove(0);
    }
    basePos.set(returnAvg(coordsX),returnAvg(coordsY),returnAvg(coordsZ));
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
  
  float returnPosDelta(){
    float d = dist(pos.x,pos.y,pos.z,basePos.x,basePos.y,basePos.z);
    d = pos.x < basePos.x ? -d : d;
    return d;
  }
}
