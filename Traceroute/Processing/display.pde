void display(String[] wNames, int[] nCircles) {

  int nWebsite = wNames.length;
  int Xiterator =  (height-(40*height/100))/(nWebsite-1);
  int Yperc = 35;
  int size = 10;
  int textBox = 100;
  int offset = 100;
  int yoffset = (height*5)/100;

  //title
  textSize(32);
  fill(#ED196E);
  strokeWeight(2);
  stroke(#ED196E);
  line((Yperc/2)*width/100-offset, (10*height/100)+20, (Yperc/2)*(width/100)-offset+400, (10*height/100)+20);
  text("Understanding Networks", (Yperc/2)*width/100-offset, (10*height/100));
  textSize(12);

  for (int i=0; i < nWebsite; i++) {

    int[] orgPositions =new int[3];
    int[] counPositions =new int[3];
    String[] orgNames = new String[3];
    String[] counNames =new String[3];
    int index = 0;

    stroke(100, 100, 100);
    strokeWeight(2);
    line((Yperc/2)*width/100-offset, yoffset+(20*height/100)+ Xiterator*i, width-((Yperc/2)*width/100)-size-offset, yoffset+(20*height/100)+ Xiterator*i);

    for ( int l=0; l< table.getStringColumn("site").length; l++) {
      //  println("-------------",l);
      if (table.getStringColumn("site")[l].equals(wNames[i])) {
        orgPositions[index] = int(float(table.getStringColumn("orgpos")[l])); 
        counPositions[index] = int(float(table.getStringColumn("counpos")[l])); 
        orgNames[index] = table.getStringColumn("org3")[l];
        counNames[index] = table.getStringColumn("coun3")[l];
        index++;
      }
    }

    for (int l=0; l < nCircles[i]; l++) {

      color circleColor = #939AA3;
      size = 10;
      int Yiterator = (width-((Yperc*width)/100))/(nCircles[i]-1);

      //----------------------------------------------------draw Website trext
      if (l == nCircles[i]-1) {
        fill(100, 100, 100);
        textAlign(LEFT);
        text("[" + wNames[i] + "]", ((Yperc/2)*width/100)+(Yiterator*(l)+40)-offset, yoffset+(20*height/100)+ Xiterator*i);
      }

      //----------------------------------------------------draw country data
      for (int j = 0; j<counPositions.length; j++) {
        if (counPositions[j] == l+1) {
          circleColor = #606466;
          size=12;
          fill(#93C83E);
          textAlign(LEFT);
          text(counNames[j], ((Yperc/2)*width/100)+(Yiterator*(l))-offset-5, yoffset+(20*height/100)+(Xiterator*i)-30, textBox, textBox);
          ellipse(((Yperc/2)*width/100)+Yiterator*l-offset, yoffset+(20*height/100)+Xiterator*i, size+10, size+10);
          break;
        } else {
        }
      }  

      //----------------------------------------------------draw orgname text
      for (int j = 0; j<orgPositions.length; j++) {
        if (orgPositions[j] == l+1) {
          circleColor = #ED196E;
          size=15;
          fill(circleColor);
          println(i);
          stroke(circleColor);
          strokeWeight(2);
          line(((Yperc/2)*width/100)+(Yiterator*l)-offset, yoffset+(20*height/100)+(Xiterator*i), ((Yperc/2)*width/100)+(Yiterator*l)-offset, yoffset+20+(20*height/100)+(Xiterator*i));
          textAlign(CENTER);
          text(orgNames[j], ((Yperc/2)*width/100)+(Yiterator*(l))-offset-(textBox/2), yoffset+25+(20*height/100)+ Xiterator*i, 100, 100);
          break;
        } else {
        }
      }         

      //Draw org text and Circles
      fill(circleColor);
      noStroke();
      fill(circleColor);
      ellipse(((Yperc/2)*width/100)+Yiterator*l-offset, yoffset+(20*height/100)+ Xiterator*i, size, size);
    }
  }
}