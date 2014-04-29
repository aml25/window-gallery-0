class CamThread extends Thread{
  
  boolean running;           // Is the thread running?  Yes or no?
  String id;                 // Thread name
  int count;                 // counter
 
  DepthCam depthCam;
  PGraphics depthImage;
  
  // Constructor, create the thread
  // It is not running by default
  CamThread (String s, DepthCam d) {
    running = false;
    id = s;
    count = 0;
    depthCam = d;
  }
  
  // Overriding "start()"
  void start () {
    // Set running equal to true
    running = true;
    // Print messages
    println("Starting thread"); 
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }
 
 
   // We must implement run, this gets triggered by start()
  void run () {
    while (running && count < 10) {
      try{
        depthImage = depthCam.drawUsers();
      }
      catch(Exception e){
        e.printStackTrace();  
      }
      
      println(id + ": " + count);
      count++;
    }
    System.out.println(id + " thread is done!");  // The thread is done when we get to the end of run()
  }
  
  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
  }
  
  PGraphics returnDepthImage(){
    return depthImage;
  }
  
  int getCount() {
    return count;
  }
}
