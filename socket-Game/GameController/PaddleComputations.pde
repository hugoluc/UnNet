void setPaddle() {

  if (sendToCorner) {
    println("----------------------------------------------------------------");
    myClient.write("llllllllllllluuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
    realPaddle.x = 0;
    realPaddle.y = 28;
    sendToCorner = false;
    startTracking = true;
  }
}


void movePaddle(PVector distance) {

  String hMov;
  String vMov;
  boolean enableHMove = false;
  boolean enableVMove = false;
  String hStringMo = "";
  String vStringMo = "";

  //move vertically--------------------------------------------------------
  if (distance.y<0) {
    vMov = "u";
  } else {
    vMov = "d";
  }

  for (int i=0; i<abs(distance.y); i++) {
    vStringMo = vStringMo + vMov;
    enableVMove = true;
  }  

  //move horizontally--------------------------------------------------------

  if (abs(distance.x) == 1 && realPaddle.x<22 && realPaddle.x>4) {  //move 1 

   if (distance.x>0) {
     hStringMo = "rrl";
   } else {
     hStringMo = "llr";
   }

   enableHMove = true;
  }

  if (abs(distance.x)>2 && abs(distance.x)%2>0) { // move more than 1

    PVector move = new PVector((int(abs(distance.x)) -1)/2, 0);

    if (distance.x>0) {
      hMov = "r";
    } else {
      hMov = "l";
    }

    for (int i=0; i < move.x; i++) {
      hStringMo = hStringMo+hMov;
    }

    enableHMove = true;
  }

  String stringToSend = "";
  PVector  UpdatePosition;

  if (enableHMove && enableHMove) { // if moved H and V
    stringToSend = hStringMo+vStringMo;
    UpdatePosition = distance;
  } else if (enableHMove) { // if moved only H
    stringToSend = hStringMo+vStringMo;
    UpdatePosition = new PVector(distance.x, 0);
  } else { // if moved only V
    stringToSend = hStringMo+vStringMo;
    UpdatePosition = new PVector(0, distance.y);
  }

  println(hStringMo+vStringMo);
  myClient.write(stringToSend);
  updatePaddle(UpdatePosition);
}




void updatePaddle(PVector _UpdatePosition) {

  realPaddle.x = realPaddle.x + _UpdatePosition.x ;
  realPaddle.y = realPaddle.y + _UpdatePosition.y;

  if (realPaddle.x==27) {
    inverted = true;
  }
  if (realPaddle.x<1) {
    inverted = false;
  }
}