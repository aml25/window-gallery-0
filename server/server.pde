import processing.net.*;

Server s;
Client c;
String input = "";
String output = "";
int port = 9000;

boolean calibrationMode = false;

void setup(){
  size(640,480);
  
  s = new Server(this, port); // Start a simple server on a port
}

void draw(){
  background(0);
  
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("calibrationMode? " + calibrationMode,10,30);
  
  //receive from clients
  c = s.available();
  if(c != null){
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); //only up to the new line
    println("from client: " + input);
    String func = split(input,"*")[0];
    if(func.equals("saveLoop")){
      saveLoop(split(input,"*"));
    }
  }
}

void saveLoop(String[] data){
  //data[0] = the function to be called
  int id = int(data[1]);
  
  JSONObject loop = new JSONObject();
  loop.setFloat("x",float(data[2]));
  loop.setFloat("y",float(data[3]));
  loop.setFloat("z",float(data[4]));
  loop.setInt("index",int(data[5]));
  loop.setFloat("radius",float(data[6]));
  
  println(loop);
}

void mousePressed(){
  if(calibrationMode){
    output = "storeLoop*\n";
    s.write(output);
  }
}

void keyPressed(){
  switch(key)
  {
  case 'c':
    calibrationMode = !calibrationMode;
    break;
  }
  
  switch(keyCode)
  {
  case LEFT:
    //rotY += 0.1f;
    output = "rotateY*0.1\n";
    s.write(output);
    break;
  case RIGHT:
    //rotY -= 0.1f;
    output = "rotateY*-0.1\n";
    s.write(output);
    break;
  case UP:
    if(keyEvent.isShiftDown()){
      //zoomF += 0.02f;
      output = "zoomF*0.02\n";
      s.write(output);
    }
    else{
      //rotX += 0.1f;
      output = "rotateX*0.1\n";
      s.write(output);
    }
    break;
  case DOWN:
    if(keyEvent.isShiftDown())
    {
      /*zoomF -= 0.02f;
      if(zoomF < 0.01)
        zoomF = 0.01;*/
      output = "zoomF*-0.02\n";
      s.write(output);
    }
    else{
      //rotX -= 0.1f;
      output = "rotateX*-0.1\n";
      s.write(output);
    }
    break;
  }
}
