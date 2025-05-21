//Gabriel Aguilar's Final. "Rainman"

import processing.serial.*;
Serial myPort;

ArrayList<Particle> rain; // Creates an array list with objects in it that are particles called rain
PVector emitter; // PVector is a type of object that Java can use. They have vectors which make things easier to program.
color rainColor; // Color is prebuilt in
color rainColorBase;

boolean pressA = false; // Controls the water color or "temp"
boolean pressD = false;

float stickX = 960; 
float stickY = 540;
float shiverPosition = 0;
float jumpPosition = 0;

void setup() {
  size(1920, 1080);
  rain = new ArrayList<Particle>(); // Makes a new array list from the one we established and makes a variable to call it called rain
  emitter = new PVector(100, 0); // The emitter is the thing that the water actually comes from. This is how we control the origin location
  rainColorBase = int(random(color(135, 206, 255),color(135, 206, 235)));
  rainColor = rainColorBase;

  for (int i = 0; i < 400; i++) { //Simple creat this until this is big enough for loop
    rain.add(new Particle());
  }

  printArray(Serial.list()); // Shows available ports in the console
  myPort = new Serial(this, Serial.list()[0], 115200); // Adjust index if needed
  myPort.bufferUntil('\n'); // resets on end ascii
}

void draw() {
  background(30, 30, 50);
  
  myPort.write('A'); // Requests the new potentiometer values. // I think this is old but i have to upload to github and dont have time to remember. IT MUST STAYYYYYYYYY

  updateRainColor(); // Updates the rain color based off A and D pressing
  updateStickmanBehavior(); //changes jump and shiverparticlePosition values

  drawStickman(stickX + shiverPosition, stickY + jumpPosition); //Changes the stickmans particlePositionition

  for (Particle p : rain) { 
    // Go through each Particle object that is currently in the rain list. 
    // For each one, temporarily call it p(Because we dont want to change the whole thing),
    // and then tell that specific raindrop to update its properties and then to draw itself on the screen.
    p.update();
    p.display();
  }
}

void updateStickmanBehavior() { 
  //Having these at the beginning reverts him back when you dont press anything
  shiverPosition = 0;
  jumpPosition = 0;

  //Sins are really useful for smooth quick animations
  if (pressD) {
    shiverPosition = sin(frameCount * 0.5) * 4;
  }
  if (pressA) {
    jumpPosition = sin(frameCount * 0.3) * -10;
  }
}

//THis is definitely changing but the x and y are carried over from the draw function
void drawStickman(float x, float y) {
  stroke(255);
  strokeWeight(5);
  fill(255);

  // Head
  ellipse(x, y - 80, 40, 40);
  // Body
  line(x, y - 60, x, y - 20);
  // Arms
  line(x - 25, y - 50, x + 25, y - 50);
  // Legs
  line(x, y - 20, x - 20, y + 20);
  line(x, y - 20, x + 20, y + 20);
}

class Particle {
  PVector particlePosition;
  PVector particleVelocity;

  Particle() {
    reset();
  }

  void reset() {
    particlePosition = emitter.copy();
    float angle = radians(random(22, 40)); //This makes it so that its in a cone
    float speed = random(3, 5);
    particleVelocity = new PVector(cos(angle), sin(angle)).mult(speed); //This whole thing is the cone and angle. Math sucks. Stack Overflow is a god
  }

  void update() {
    particlePosition.add(particleVelocity);
    if (particlePosition.x > width || particlePosition.y > height) reset();// This is kind of new Xi taught it to me. It's like a condensed ay if writing an if statement.
  }

  void display() { //Draws raindrops
    stroke(rainColor);
    line(particlePosition.x, particlePosition.y, particlePosition.x - particleVelocity.x * 1.5, particlePosition.y - particleVelocity.y * 1.5);
  }
}

void updateRainColor() {
  float r = red(rainColor); //Red 
  float g = green(rainColor);
  float b = blue(rainColor);

  float targetR = red(rainColorBase);
  float targetG = green(rainColorBase);
  float targetB = blue(rainColorBase);

  if (pressA) {
    targetR = 255;
    targetG = 0;
    targetB = 0;
  } else if (pressD) {
    targetR = 255;
    targetG = 255;
    targetB = 255;
  }

  r = lerp(r, targetR, 0.05);
  g = lerp(g, targetG, 0.05);
  b = lerp(b, targetB, 0.05);

  rainColor = color(r, g, b);
}

//Serial function that listens to the values coming from ESP32
void serialEvent(Serial myPort) { //Makes things easier.
  String input = myPort.readStringUntil('\n'); //Sent on Arduino end.
  if (input != null) {  // Is anything received? Nah? 
    input = trim(input); // I learned this from my friend, Shong. This makes it so that even if you have stray characters the data still does its purpose.
    String[] potVals = split(input, ','); // This is part of what shong taught me. Essentially you can take the data and turn it into an strings in an array separated by commas
    if (potVals.length == 2) { // This is where it becomes useful. Instead of reading for a break in the code it just checks if the serial data comes to a new line, it checks if it is the correct number of values. Just speeds things up.
      int pot1 = int(potVals[0]); // Saying that the first value in the array of 2 is pot1's value
      int pot2 = int(potVals[1]); // Saying that the second value in the array of 2 is pot2's value

      // Set thresholds for triggering A and D behavior
      pressA = (pot1 > 700);   //If pot1 is greater than 700 activate the pressA function I used when controlling the stickman directly through the keyboard.
      pressD = (pot2 > 700);   // Same here. This just makes it so that I dont have to worry about mapping. Besides the LERP actually makes it seem like the potentiometer is working correctly.
      //TLDR; If you dont like programming Arduino. Do it all on the software side llololololol. Processing ftw.
    }
  }
}
