Table table;

void setup() {

  fullScreen();
  //size(800, 600);
  background(48, 50, 53);
  smooth(8);

  table = loadTable("vizData.csv", "header");

  int[] nJumps = int(float(getSet(table.getStringColumn("njumps"))));
  String[] wNames = getSet(table.getStringColumn("site"));

  display(wNames, nJumps);
}