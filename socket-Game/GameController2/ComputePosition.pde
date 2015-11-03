PVector mapLight(PVector _lightPos) {


  PVector gridPos = new PVector(0, 0);

  if (inverted) {
    gridPos.x = int(map(_lightPos.x, -25, 815, 0, 28));
    gridPos.y = int(map(_lightPos.y, -5, 605, 0, 61));//0-32//28-60
  } else {
                                     //(AreaW/3),(floor(width/area)*area)+2.5area
    gridPos.x = int(map(_lightPos.x, -areaW/2, 825, 0, 28));
    gridPos.y = int(map(_lightPos.y, -5, 605, 0, 61));
  }

  if(gridPos.y<29){
    gridPos.y=28;
  }

  return gridPos;
}

PVector distance(PVector origin, PVector destination) {

  PVector distance = new PVector(0, 0);
  distance.x = destination.x - origin.x;
  distance.y = destination.y - origin.y;

  if (distance.y > 32) {
    distance.y = 32;
  }

  return distance;
}