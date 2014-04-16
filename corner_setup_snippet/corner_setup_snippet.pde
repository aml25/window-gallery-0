float[][] corners = new float[4][2]; /*(0)*******STREET*******(1)*/
                                     /****************************/
                                     /****************************/
                                     /****************************/
                                     /****************************/
                                     /*(2)*******WINDOW*******(3)*/



void setup(){
  size(500,500);
  
  //corners = returnSavedCorners();  
  corners = returnSavedCorners();
}

void draw(){
  
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
  for(int i=0;i<c.length;i++){
    for(int u=0;u<c[i].length;u++){
      s[0] += c[i][u] + "";
      if(u<c[i].length -1)
        s[0] += ",";
    }
    if(i<c.length -1)
      s[0] += ";";
  }
  saveStrings("corners.text",s);
  println("saved the corners");
}

void keyPressed(){
  String s = key+"";
  println(key);
  println(s);
  println(s.equals('s'));
  switch(key){
    case 's':
      println("pressed s");
      break;  
  }
    
  if(key != 'S' || key != 's'){
    int index = int(s);
    
    if(index >= 0 && index <= corners.length){
      corners[index][0] = mouseX;
      corners[index][1] = mouseY;
      println("setting corner " + index + " to " + mouseX + "," + mouseY);
    }
  }
  else{
    saveCorners(corners);
  }
}
