class CameraWindow{

  PGraphics pg;
  int frameCounter = 0;

  CameraWindow(){
    pg = createGraphics(640,480);
  }
  
  PGraphics drawCameraWindow(PImage camImage){
    pg.beginDraw();
    pg.image(camImage,0,0);
    pg.endDraw();
    
    return pg;
  }  
}
