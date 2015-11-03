//---------------------------------------------------------return pixel position of light
PVector getLightPos() {

  //-------------------
  for (int x=0; x< video.width; x =x+iterator) {
    for (int y=0; y< video.height; y=y+iterator) {

      int id=-1;


      int thisPixel = (x+ y*video.width);
      color ColorFromImage = video.pixels[thisPixel]; 

      float redP = red(ColorFromImage);
      float greenP = green(ColorFromImage);
      float blueP = blue(ColorFromImage);

      if (redP>treshold && greenP>treshold && blueP>treshold) {
        id++;   
        PVector point = new PVector(width-x, y);
        vectors.add(point);
      }
    }
  }
  //------------------------

  if (vectors.size()>0) {


    int x1 = width;
    int x2 = 0;
    int y1 = width;
    int y2 = 0;

    int to=0;
    int bo=0;
    int le=0;
    int ri=0;

    for (int t=0; t<vectors.size(); t++) {
      //  ellipse(vectors.get(t).x, vectors.get(t).y, 10, 10); 

      //get highest
      if (vectors.get(t).y < y1) {
        to=t;
        y1 = int(vectors.get(t).y);
      }

      //get lowest
      if (vectors.get(t).y > y2) {
        bo=t;
        y2 = int(vectors.get(t).y);
      }

      //get rigth
      if (vectors.get(t).x < x1) {
        ri=t;
        x1 = int(vectors.get(t).x);
      }

      //get left
      if (vectors.get(t).x > x2) {
        le=t;
        x2 = int(vectors.get(t).x);
      }
    }

    int pointerWidth = y2-y1;
    int pointerHeight = x2-x1;

    fill(0, 0, 255);
    //  ellipse(vectors.get(to).x, vectors.get(to).y, 10, 10);
    //  ellipse(vectors.get(bo).x, vectors.get(bo).y, 10, 10);
    //println("PIXEL LEFT=", vectors.get(le).x);
    // ellipse(vectors.get(le).x, vectors.get(le).y, 10, 10);
    // ellipse(vectors.get(ri).x, vectors.get(ri).y, 10, 10);

    // fill(0, 255, 0, 100);
    // rectMode(CORNER);
    // rect(x1, y1, pointerHeight, pointerWidth);



    middle = new PVector(x1+(pointerHeight/2), y1+(pointerWidth/2));
    //middle = new PVector(x1+(pointerHeight/2), y1+(pointerWidth/2));

    //println("----------", middle.x);

    fill(0);
    ellipse(middle.x, middle.y, 10, 10);
  }

  vectors.clear();  
  return middle;
}


void drawGrid(PVector _lightGridPos) {

  if (inverted) {

    for (float i=width; i>0; i=i-paddleWidth/3) {
      //println("-------------------------------------------");
      fill(255, 255, 255, 10); 
      rect(i, height/2, paddleWidth, height);
    }

    for (float i=height; i>0; i=i-paddleHeight) {
      rectMode(CENTER);
      fill(255, 255, 255, 0); 
      rect(width/2, i, width, paddleHeight);
      //println("---------", i);
    }
  } else {
    for (float i=0; i<width; i=i+paddleWidth/3) {
      rectMode(CENTER);
      fill(255, 255, 255, 10); 
      rect(i, height/2, paddleWidth, height);
    }

    for (float i=0; i<height; i=i+paddleHeight) {
      rectMode(CENTER);
      fill(255, 255, 255, 0); 
      rect(width/2, i, width, paddleHeight);
      //println("---------", i);
    }
  }
  
  
    fill(255, 255, 255, 200);
    rectMode(CENTER);
    rect(_lightGridPos.x*30, _lightGridPos.y*10, 90, 10);

    fill(255, 0, 0);
    rectMode(CENTER);
    rect(realPaddle.x*30, realPaddle.y*10, 90, 10);
  
  
  
}