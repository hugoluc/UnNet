var s = require('net').Socket();

var printed = true;
var capture;
var threshold = 60;
var colorMean = 0;
var calculate = false;
var realW;
var realH;
var density;

function setup() {
  devicePixelScaling();
  //createCanvas(windowWidth, windowHeight);
  createCanvas(400,400);
  capture = createCapture(VIDEO);
  capture.size(width, height);
  capture.hide()
  density = pixelDensity;
  realW = width*density;
  realH = height*density;
  console.log(width,height);
  console.log("size:",realW,"x",realH);
}


function draw() {
  background(255);
  //var x = image(capture, 0, 0, width, height);
  //pixelTest = get(x);

var img =  image(capture, 0, 0, width, height);
pix = get(capture);

//print(calculate);
//console.log(pixels.length);

if (calculate == true){
  var id = 0
  for (var r=0; r<pixels.length; r = r+(realW/10*4)){

      index = floor(r)
      pxPos = ((index)%realW);
      pyPos = (floor((index)/realW));
      stroke(pixels[index],pixels[index+1],pixels[index+2]);
      rect(pxPos,pyPos,1,1);
      id++

      if(printed){
        //console.log(id,": ",pxPos,pyPos);
      }

      console.log(index);

      //R+R+G+G+G+B
      var PxLumina = (2*(pixels[index])+3*(pixels[index+1])+pixels[index+2])/6

      if (PxLumina < threshold){
        //get pixel position
        stroke(0,0,0);
        rect(pxPos,pyPos,20,20);

    }
//    console.log("total=",id);
  }
        printed = false   

  if(printed){
    console.log(pixels.length);  
  }

  //console.log("------------",id);

}


}

function mousePressed(){

  printed = true;
  calculate = !calculate;

}
