import processing.net.*;

Client c;
String input;
String output;
boolean connected = false;
int port = 9000;
int id = 1;
int loopIndex = 0;

float rotY = 0;
float rotX = 0;
float zoomF = 0;

void setup(){
  size(640,480);
  
  while(!connected){
    try{
      c = new Client(this, "127.0.0.1", port);
      println(c.ip());
      connected = true;
    }
    catch(Exception e){
      delay(1000); //wait 1 second
      println("waiting for server to start");
    }
  }
}

void draw(){
  background(0);
  
  //receive from server
  if(c.available() > 0){
    input = c.readString();
    input = input.substring(0, input.indexOf("\n")); //only up to the new line
    println("from server: " + input);
    String func = split(input,"*")[0];
    if(func.equals("storeLoop")){
      println("grabbing location");
      storeLoop();
    }
    else if(func.equals("rotateY")){
      rotY += float(split(input,"*")[1]);
      println("rotY = " + rotY);
    }
    else if(func.equals("rotateX")){
      rotX += float(split(input,"*")[1]);
      println("rotX = " + rotX);
    }
    else if(func.equals("zoomF")){
      zoomF += float(split(input,"*")[1]);
      println("zoomF = " + zoomF);
    }
  }
}

void storeLoop(){
  output = "saveLoop*" + id + "*" + random(0,1000) + "*" + random(0,1000) + "*" + random(0,1000) + "*" +
           loopIndex + "*" + random(0,250) + "\n";
  delay(id*200);
  c.write(output);
  
  loopIndex++;
}

void mousePressed(){
  output = id + "*user in loop #" + int(random(0,5)) + "\n";
  c.write(output);
}
