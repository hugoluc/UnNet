String[] getSet(String[] data) { 
  
  String[] setData = new String[data.length];
  int index = 0;
  int addedCount = 1;
  boolean included = false;

  for (String value : data) {


    included  = false;

    for (int l=0; l < addedCount; l++) {

     // println("comparing: ", value, "<to>", setData[l], "--", value.equals(setData[l]) );

      if (value.equals(setData[l])){
       // println("----IMEM ALREADY INCLUDED");
        included = true;
      } 

      if (l == addedCount-1 && included == false && !value.equals("*")) {
        //println("entry added! over inde:", index, "\n", "--------------------");
        addedCount++;
        setData[index] = value;
        index++;
        break;
      }
    }
  }
  
  
  String[] returnData = new String[index];
  
  for (int i=0;i<index;i++){
    
    returnData[i] = setData[i];
  
  }

  return returnData;
}