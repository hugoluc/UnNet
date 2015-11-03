import processing.video.*; //<>//
import processing.net.*;

//SOcket variables
Client myClient;         
String data;                       
String ipAddress = "172.16.245.119"; 
//String ipAddress = "192.168.1.151"; 

//image capture variables
Capture video;
boolean sendToCorner = false;
int recCount = 0;
int treshold = 200;
int iterator = 2;
PVector middle = new PVector(0, 0);
ArrayList<PVector> vectors = new ArrayList<PVector>();


//paddle variables
boolean startTracking = true;
int paddleWidth = 90;
int paddleHeight = 10;
int areaW = paddleWidth/3;
int areaH = paddleHeight;
boolean inverted = false;
PVector realPaddle = new PVector(0, 0);

//----------------------------------------------------------------------------------Setup and draw---------------------------------------------------------------------------------------------


void setup() {
  size(800, 600);
  myClient = new Client(this, ipAddress, 8080);
  //fullScreen();
  video= new Capture(this, width, height);
  video.start();
}

void draw() {

  frameRate(10);
  setPaddle();
  //background(0);

  if (video.available ()) {
    recCount = 0;
    video.read();
    video.loadPixels();

    image(video, 0, 0, width, height);
    pushMatrix();
    scale(-1.0, 1.0);
    image(video, -video.width, 0);
    popMatrix();

    setPaddle();

    if (startTracking) {

      PVector lightGridPos = mapLight(getLightPos());
      PVector _distance = distance(realPaddle, lightGridPos);

      println("LighGridPos= ", lightGridPos.x);
      println("RealpaddlePos= ", realPaddle.x);
      println("distance= ", _distance);
      movePaddle(_distance);
      drawGrid(lightGridPos);
    }
  }
}


////--------------------------------------------------------------------------------FUNCTIONS-------------------------------------------------------------------------------------------------

void mousePressed() {
  sendToCorner = true;
}

void keyPressed() {
  if (key == 'x') myClient.write('x');
}