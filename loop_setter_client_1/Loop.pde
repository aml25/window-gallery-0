class Loop{
  
  int index;
  PVector loc;
  float radius;
  boolean userInside = false;
  
  Loop(int i, PVector l){
    index = i;
    loc = l;
  }
  
  void drawLoop(){    
    //draw the radius ellipse
    if(userInside){
      stroke(255,0,255,150);
    }
    else{
      stroke(255,255,0,150);
    }
    noFill();
    pushMatrix();
    translate(loc.x,loc.y,loc.z);
    sphere(radius);
    
    fill(255);
    noStroke();
    sphere(25);
    popMatrix();
  }
  
  void setRadius(float r){
    radius = r;
  }
  
  void checkIfUserInside(ArrayList<PVector> locs){
    for(int i=0;i<locs.size();i++){
      if(locs.get(i).z < 0 || locs.get(i).z > 0){ //as long as it's an active user
        if(PVector.dist(locs.get(i), loc) <= radius){
          userInside = true;
          break;
        }
        else{
          userInside = false;
        }
      }
      else{
        userInside = false;
      }
    }
  }
  
  
}
