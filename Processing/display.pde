void display(String[] wNames, int[] nCircles) {

  String teste = "white";
  
  int nWebsite = wNames.length;
  int Xiterator =  (height-(20*height/100))/(nWebsite-1);
  color circleColor = #939AA3;
  int size = 10;

  for (int i=0; i < nWebsite; i++) {
    
    int[] positions =new int[3];
    int index = 0;

    for ( int l=0; l< table.getStringColumn("site").length; l++) {
        //  println("-------------",l);
      if (table.getStringColumn("site")[l].equals(wNames[i])) {
        positions[index] = int(float(table.getStringColumn("orgpos")[l])); 
        index++;
      }
    }

    println(positions);

    for (int l=0; l < nCircles[i]; l++) {
      int Yiterator = (width-(20*width/200))/(nCircles[i]-1);

      // draw Website trext
      if (l == nCircles[i]-1) {
        text(wNames[i], (5*width/100)+(Yiterator*l)-100, (10*height/100)+ Xiterator*i);
      }

      for(int j = 0; j<positions.length; j++){
        if(positions[j] == l+1){
          println(l);
          teste = "pink";
          circleColor = #ED196E;
          break;
        }else{
          circleColor = #939AA3;
        }
      }
       println(l,teste,circleColor);      

      //Draw org text and Circles
      noStroke();
      fill(circleColor);
      ellipse((5*width/100)+Yiterator*l, (10*height/100)+ Xiterator*i, size, size);
    }
  }
}