import processing.serial.*;
Serial myPort;


int playerSize = 50;
int bulletSize = 10;

int bulletYloc = 0;

int potValue = 0;

int player1Xloc;
int player2Xloc;
int bgChange;

void setup() {
  size(900, 800);
  background(152, 100, 200);
  player1Xloc = 0;
  player2Xloc = width - playerSize;
  
  printArray(Serial.list());
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 115200);
}

void draw() {
    if (myPort.available() > 0) {
    potValue = myPort.read(); 
  }
  
  player1Xloc = int(map(potValue, 0, 1023, 100, width));
  player2Xloc = potValue;
  
  bgChange = potValue;
  
  background(bgChange);

  // Player1
  fill(255,0,0);
  rect(player1Xloc, height / 2, playerSize, playerSize);

  // Player2
  fill(0,0,255);
  rect(player2Xloc, height / 2, playerSize, playerSize);
  
  // Enemy
  fill(0,255,0);
  ellipse(width/2, height/4, 100, 100);
  
  // flipper
  fill(100,100,100);
  triangle(potValue, potValue, 100, height, 40, height);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    player1Xloc--;
    player2Xloc++;
  } else if (keyCode == LEFT) {
    player1Xloc++;
    player2Xloc--;
  }
}
