/*
  Ball Drop Client
 Language:  Processing
 
 Starts a network client that connects to a server on port 8080,
 sends any keystrokes pressed. 
 
 For use with the Ball Drop Server game.
 
 Created sometime in 2007
 modified 10 Sept 2012
 by Tom Igoe
 
 */


import processing.net.*;

Client myClient;                   // instance of the net Client
String data;                       // string to hold incoming data
String ipAddress = "128.122.151.74";    // address of the server goes here
int servScreenWidth = 9, servScreenHeight = 32;
int lightX, lightY;
float paddleX, paddleY;

void setup() {
  // establish the background and foreground:
  size(800, 600);      
  background(50);
  fill(200);
  // Connect to server on port 8080
  myClient = new Client(this, ipAddress, 8080);
  background(#000045);
  fill(#eeeeff);
}

void draw() {
  background(#000045);
  //xprintln("data" ,data);
  paddleX = mouseX;
  paddleY = mouseY;
  println(mouseX);
  noFill();
  stroke(255);
  rect(paddleX, paddleY, 100, 10);
  // If there's incoming data from the client:
  if (myClient.available() > 0) { 
    // get the data:
    data = myClient.readString(); 
    fill(#eeeeff);
    text(data, 10, 10);
    println("data", data);

    //movePadle();
    //noCursor();
  }
}



void movePadle() {
  lightX = int(map(mouseX, -(width/9)/2, width+((width/9)/2),0,10)); //mapping size horiz to 0-9
  //println(mouseX, clientScreenWidth);
}

void keyPressed() {
  // send out anything that's typed:
  myClient.write(key);
  if (keyCode == DOWN) myClient.write('d');
  if (keyCode == UP) myClient.write('u');
  if (keyCode == LEFT) myClient.write("llllll" );
  if (keyCode == RIGHT) myClient.write('r');
}