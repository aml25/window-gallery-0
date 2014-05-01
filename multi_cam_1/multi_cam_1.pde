import SimpleOpenNI.*; 
ArrayList<DepthCam> depthCams = new ArrayList<DepthCam>();
ArrayList<PGraphics> camImages = new ArrayList<PGraphics>();

void setup(){
  size(640*2,480,P3D);
  
  SimpleOpenNI.start();
   // print all the cams 
  StrVector strList = new StrVector();
  SimpleOpenNI.deviceNames(strList);
  for(int i=0;i<strList.size();i++){
    println(i + ":" + strList.get(i));
    depthCams.add(new DepthCam(i,this));
    camImages.add(new PGraphics());
  }
}

void draw(){
  background(255);
  
  for(int i=0;i<depthCams.size();i++){
    println("drawing image at " + (i*(width/2)));
    String s = "updateCam" + i;
    thread(s);
    try{
      image(camImages.get(i),i*(width/2),0);
    }
    catch(Exception e){
      e.printStackTrace();
    }
  }
}

void updateCam0(){
  depthCams.get(0).updateUsers();
  try{
    camImages.set(0,depthCams.get(0).drawUsers());
  }
  catch(Exception e){
    e.printStackTrace();  
  }
}
void updateCam1(){
  depthCams.get(1).updateUsers();
  try{
    camImages.set(1,depthCams.get(1).drawUsers());
  }
  catch(Exception e){
    e.printStackTrace();  
  }
}
