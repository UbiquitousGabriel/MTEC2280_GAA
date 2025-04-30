ArrayList<Particle> rain; // Creates an array list with objects in it that are particles called rain
PVector emitter; // PVector is a type of object that Java can use. They have vectors which make things easier to program.
color rainColor; // Color is prebuilt in
color rainColorBase;

boolean pressA = false; // Controls the water color or "temp"
boolean pressD = false;

float stickX = 150; 
float stickY = 300;
float shiverparticlePositionition = 0;
float jumpparticlePositionition = 0;

void setup() {
  size(600, 400);
  rain = new ArrayList<Particle>(); // Makes a new array list from the one we established and makes a variable to call it called rain
  emitter = new PVector(100, 0); // The emitter is the thing that the water actually comes from. This is how we control the origin location
  rainColorBase = color(135, 206, 235);
  rainColor = rainColorBase;

  for (int i = 0; i < 400; i++) { //Simple creat this until this is big enough for loop
    rain.add(new Particle());
  }
}

void draw() {
  background(30, 30, 50);

  updateRainColor(); // Updates the rain color based off A and D pressing
  updateStickmanBehavior(); //changes jump and shiverparticlePosition values

  drawStickman(stickX + shiverparticlePositionition, stickY + jumpparticlePositionition); //Changes the stickmans particlePositionition

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
  shiverparticlePositionition = 0;
  jumpparticlePositionition = 0;

  //Sins are really useful for smooth quick animations
  if (pressD) {
    shiverparticlePositionition = sin(frameCount * 0.5) * 4;
  }
  if (pressA) {
    jumpparticlePositionition = sin(frameCount * 0.3) * -10;
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
    float angle = radians(random(30, 60)); //This makes it so that its in a cone
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
  float r = red(rainColor); //Red Green blue are part of processing
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

void keyPressed() {
  if (key == 'a' || key == 'A') pressA = true;
  if (key == 'd' || key == 'D') pressD = true;
}

void keyReleased() {
  if (key == 'a' || key == 'A') pressA = false;
  if (key == 'd' || key == 'D') pressD = false;
}
