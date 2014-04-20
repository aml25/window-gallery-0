class Loop{
  
  int index;
  PVector loc;
  ArrayList<Boolean> closestLoop = new ArrayList<Boolean>();
  int isAClosestLoop = 0;
  
  Loop(int i, PVector l){
    index = i;
    loc = l;
  }
  
  void drawLoop(){
    if(isAClosestLoop == 1){
      fill(255,0,0);  
    }
    else{
      fill(255);
    }
    noStroke();
    ellipse(loc.x,loc.y,25,25);  
  }
  
  void addClosestBool(boolean b){
    closestLoop.add(b);  
  }
  
  void clearClosestBools(){
    closestLoop.clear();  
  }
  
  void figureOutIfClosest(){
    for(int i=0;i<closestLoop.size();i++){
      if((boolean)closestLoop.get(i) == true){
        isAClosestLoop = 1;
        break;
      }
      else{
        isAClosestLoop = 0;  
      }
    }  
  }
}
