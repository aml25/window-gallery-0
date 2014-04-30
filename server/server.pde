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
    println(input);
    String a = split(input,"*")[0];
    if(a.equals("saveLoop")){
      saveLoop(split(input,"*"));
    }
  }
}

void saveLoop(String[] data){
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
    output = "storeLoop\n";
    s.write(output);
  }
}

void keyPressed(){
  if(key == 'c'){
    calibrationMode = !calibrationMode;
  }  
}
