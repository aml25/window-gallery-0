float[][] corners = new float[4][2]; /*(0)*******STREET*******(1)*/
                                     /****************************/
                                     /****************************/
                                     /****************************/
                                     /****************************/
                                     /*(3)*******WINDOW*******(2)*/



void setup(){
  size(500,500);
  
  corners = returnSavedCorners();
  println(corners[0]);
}

void draw(){
  background(0);
  fill(255);
  noStroke();
  for(int i=0;i<corners.length;i++){
    ellipse(corners[i][0],corners[i][1],10,10);
  }
}

float[][] returnSavedCorners(){
  float[][] c = new float[4][2];
  try{
    String[] cornerPairs = loadStrings("corners.txt")[0].split(";");
    for(int i=0;i<cornerPairs.length;i++){
      String[] cornersSplit = cornerPairs[i].split(",");
      for(int u=0;u<cornersSplit.length;u++){
        c[i][u] = float(cornersSplit[u]);
      }
    }
  }
  catch(Exception e){
    e.printStackTrace();
  }
  return c;
}

void saveCorners(float[][] c){
  String[] s = new String[1];
  s[0] = "";
  for(int i=0;i<c.length;i++){
    for(int u=0;u<c[i].length;u++){
      s[0] += c[i][u] + "";
      if(u<c[i].length -1)
        s[0] += ",";
    }
    if(i<c.length -1)
      s[0] += ";";
  }
  saveStrings("corners.txt",s);
  println("saved the corners");
}

float[] returnNormalizedXY(float x, float y){
    float[] normalized = new float[2];
    
}

void keyPressed(){
  switch(key){
    case 's':
      println("pressed s");
      saveCorners(corners);
      break; 
    default:
      int index = int(key+"");
    
      if(index >= 0 && index < corners.length){
        corners[index][0] = mouseX;
        corners[index][1] = mouseY;
        println("setting corner " + index + " to " + mouseX + "," + mouseY);
      }
  }
}
