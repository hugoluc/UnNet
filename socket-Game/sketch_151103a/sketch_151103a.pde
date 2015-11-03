import processing.net.*;
Client myClient;
int count = 0;
String ipAddress = "192.168.1.151"; 
boolean teste = true;

void setup() {
  size(1, 1);
  myClient = new Client(this, ipAddress, 8080);
}

void draw() {

  if (count > 5) {
    if (teste) {
      myClient.write("rrl");
      teste = !teste;
    } else {
      myClient.write("llr");
      teste= !teste;
    }
    count = 0;
  }

  count++;
}

void keyPressed() {
  if (key == 'x') myClient.write('x');
}