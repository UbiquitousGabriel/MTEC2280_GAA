import processing.serial.*;
Serial myPort;
byte[] val;


int playerSize = 50;
int bulletSize = 10;
int enemySize = 100;

int bulletYloc = 0;

int potValue = 0;

int player1Xloc;
int player2Xloc;
int bgChange = 0;

void setup() {
  size(900, 800);
  background(152, 100, 200);
  player1Xloc = 0;
  player2Xloc = width - playerSize;
  
  printArray(Serial.list());
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 115200); //Has to be in quotes for the name to be functional. Otherwise eclare string at the array number.
}

void draw() {
    if (myPort.available() > 0) {
    //read received bytes into array until 'e' ASCII value is received
        val = myPort.readBytesUntil('e'); 

  }
  
  if (val != null && val.length == 5){ //I was getting an error that requier me to check for null. Will ask during class.
  //mapping -128 to 127 into 0 to 255 range, and Casting to integer
    int potA = int(map(val[0], -128, 127, 0, 255));
    int potB = int(map(val[1], -128, 127, 0, 255));
  
  //casting Byte button values to boolean
    boolean buttonA = boolean(val[2]);
    boolean buttonB = boolean(val[3]);
  

  
  background(bgChange);

  // Player1
  fill(255,0,0);
  rect(potA, height / 2, playerSize, playerSize);

  // Player2
  fill(0,0,255);
  rect(potB, height / 2, playerSize, playerSize);
  
  
  if (buttonA)
  {
  enemySize = 100;
  } else {
  enemySize = 200;
  }
  
  if (buttonB){
    bgChange = 255;
  } else {
    bgChange = 0; 
  }
  
  
  // Enemy
  fill(0,255,0);
  ellipse(width/2, height/4, enemySize, enemySize);
  
  // flipper
  fill(100,100,100);
  triangle(potA, potB, width/2.4, height, width/1.8, height);
  
  
  
}

}
//void keyPressed() {
//  if (keyCode == RIGHT) {
//    player1Xloc--;
//    player2Xloc++;
//  } else if (keyCode == LEFT) {
//    player1Xloc++;
//    player2Xloc--;
//  }
//}
