(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var s = require('net')

console.log(s)

var printed = true;
var capture;
var threshold = 204;
var colorMean = 0;
var calculate = false;
var realW;
var realH;
var density;
var cIter = 20;
var rIter = 20;

function setup() {
	devicePixelScaling(false);
  //createCanvas(windowWidth, windowHeight);
  createCanvas(800,600);
  capture = createCapture(VIDEO);
  capture.hide()
  density = pixelDensity;
  realW = width*density;
  realH = height*density;
  console.log(capture);
  console.log(density);
  console.log("size:",realH,"x",realW);
}


function draw() {
  background(255);
  //var x = image(capture, 0, 0, width, height);
  //pixelTest = get(x);

  var img = image(capture, 0, 0, width, height);
  loadPixels();

  rect(0,0,400,10);

  if(calculate){//------------------------------------------------------------
  console.log(calculate);
  for (r=0; r<realH; r=r+rIter){
    for(c=0;c<realW;c=c+cIter){

      var id=(r*realW*2)+(c*4);
      var PxLumina = (2*(pixels[id])+3*(pixels[id+1])+pixels[id+2])/6

      if(PxLumina > threshold){
        fill(pixels[id],pixels[id+1],pixels[id+2]);
        rect(c,r,10,10)
      }

    }

  }

  //--------------------------------------------------------------
  }


}

function mousePressed(){

	printed = true;
  calculate = !calculate;

}

},{"net":2}],2:[function(require,module,exports){

},{}]},{},[1]);
