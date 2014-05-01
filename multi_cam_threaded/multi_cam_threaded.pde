import SimpleOpenNI.*; 
//ArrayList<DepthCam> depthCams = new ArrayList<DepthCam>();
ArrayList<CamThread> camThreads = new ArrayList<CamThread>();

void setup(){
  size(640*2,480,P3D);
  
  SimpleOpenNI.start();
   // print all the cams 
  StrVector strList = new StrVector();
  SimpleOpenNI.deviceNames(strList);
  for(int i=0;i<strList.size();i++){
    println(i + ":" + strList.get(i));
    DepthCam d = new DepthCam(i,this);
    //depthCams.add(new DepthCam(i,this));
    camThreads.add(new CamThread("cam"+i,d));
  }
}

void draw(){
  background(255);
  
  for(int i=0;i<camThreads.size();i++){
    if(!camThreads.get(i).running){
      try{
      camThreads.get(camThreads.size()-1).start();
      }
      catch(Exception e){
       e.printStackTrace();
     }
    }
    println("drawing image at " + (i*(width/2)));
    try{
    image(camThreads.get(i).returnDepthImage(),i*(width/2),0);
    }
    catch(Exception e){
      e.printStackTrace();  
    }
  }
  
}
