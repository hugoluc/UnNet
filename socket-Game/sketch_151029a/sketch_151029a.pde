import processing.video.*; //<>// //<>//
Capture video;

int recCount = 0;
int treshold = 253;
int iterator = 20;
ArrayList<PVector> vectors = new ArrayList<PVector>();
ArrayList<ArrayList<Integer>> Groups = new ArrayList<ArrayList<Integer>>();
IntList exclusions = new IntList();

void setup() {
  size(640, 480);
  //fullScreen();
  video= new Capture(this, width, height);
  video.start();
}

void draw() {

  if (video.available ()) {
    recCount = 0;
    video.read();
    video.loadPixels();
    image(video, 0, 0);
    int id=-1;
    PVector BrightPixels[] = new PVector[9000];
    //---------------------------------------------------------------------------
    for (int x=0; x< video.width; x =x+iterator) {
      for (int y=0; y< video.height; y=y+iterator) {

        int thisPixel = (x+ y*video.width);
        color ColorFromImage = video.pixels[thisPixel]; 
        float pixelBrightness = brightness(ColorFromImage);

        if (pixelBrightness>treshold) {

          id++;   

          PVector point = new PVector(x, y);
          vectors.add(point);

          fill(255, 0, 0);
          ellipse(x, y, 10, 10);
        }
      }
    }

    if (vectors.size()>0) {
      checkConection(0, vectors, 0);
      fill(0, 255, 0);
      ellipse(vectors.get(0).x, vectors.get(0).y, 10, 10);
    }
    //-------------------------------------------------------------------------
  }

  exclusions.clear();
  vectors.clear();
}

int checkConection(int _target, ArrayList<PVector> _points, int group) {

  fill(0, 0, 255);
  ellipse(_points.get(_target).x, _points.get(_target).y, 10, 10);

  recCount++;
  println(recCount, "----------------------------------------------------");

  PVector target = _points.get(_target);
  exclusions.append(_target);
  println("---", _target);
  println(exclusions);

  boolean excluded = false;

  for (int i=0; i < _points.size(); i++) { // scan all points
    if (target.dist(_points.get(i)) <= iterator && _target != i) { //it is connected!!
      println("pixeln:", _target, "is conected to:", i);
      excluded = false;
      //-----------------------------------------------------------------------------------check excluded
      for (int l=0; l<exclusions.size(); l++) {//check all in exclusion list
        println("checking exclusions n:", exclusions.get(l), " to ", i);
        if (i == exclusions.get(l)) {
          println("intem included");
          excluded = true;
          break;
        }
      }

      println("excluded is now: ", excluded );
      //-----------------------------------------------------------if not excluded then recursive
      if (!excluded) {
        println("NOT an Exception");

        if (recCount < 100) {
          println("calling on target:", i);
          checkConection(i, _points, group);
        }

        //add target to the group
        // Groups.get(group).add(_target);
      }
    }
  }

  println();

  return 0;
}