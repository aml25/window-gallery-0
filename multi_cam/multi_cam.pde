import SimpleOpenNI.*; 
ArrayList<DepthCam> depthCams = new ArrayList<DepthCam>();

void setup(){
  size(640*2,480,P3D);
  
  SimpleOpenNI.start();
   // print all the cams 
  StrVector strList = new StrVector();
  SimpleOpenNI.deviceNames(strList);
  for(int i=0;i<strList.size();i++){
    println(i + ":" + strList.get(i));
    depthCams.add(new DepthCam(i,this));
  }
}

void draw(){
  background(255);
  
  for(int i=0;i<depthCams.size();i++){
    println("drawing image at " + (i*(width/2)));
    image(depthCams.get(i).drawUsers(),i*(width/2),0);
  }
}
