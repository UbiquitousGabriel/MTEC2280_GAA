/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
||||||||||||||||||||||||||||||||||||
 "LED BLINK w/ button!"                                  
  by Gabriel Aguilar using Ian Pokorny's Initial code.
  MTEC-2280       
||||||||||||||||||||||||||||||||||||
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/

//DECLARE GLOBAL VARIABLES UP HERE
const int ledPinA = 4;   //constant integer set to LED pin #
const int ledPinB = 5;   //constant integer set to LED pin #
const int ledPinC = 6;   //constant integer set to LED pin #
const int ledPinD = 7;   //constant integer set to LED pin #
const int pushButton = 18; //constant integer set to push button #
int ledIndex = 0; // Tracks the current Led in the array above.
int ms = 500;           //integer variable storing delay amount

void setup() //runs once at start-up [power on or reset button]
{    
  pinMode(pushButton, INPUT); //set button as an output
  pinMode(ledPinA, OUTPUT);  //set LED pin to output voltage
  pinMode(ledPinB, OUTPUT);
  pinMode(ledPinC, OUTPUT);
  pinMode(ledPinD, OUTPUT);

  Serial.begin(115200);
}

void loop() //loop function runs forever
{ //START OF LOOP


 //if(digitalRead(pushButton) == HIGH){  //if the button is pressed
  ledIndex = (ledIndex + 1) % 5; //increase the index by 1 but make sure its less than five
  triggerLED(); // then trigger call the triggerled function
  delay(ms); // delay just in case.
 //}

} // END OF LOOP [will begin again from start of loop]





void triggerLED() { 
  // Turn off all LEDS before starting new one. Not really necessary
  // digitalWrite(ledPinA, LOW);
  // digitalWrite(ledPinB, LOW);
  // digitalWrite(ledPinC, LOW);
  // digitalWrite(ledPinD, LOW);

  if (ledIndex == 0) { // This is probably super inefficient but hey if i dont have to delve into arrays I WONT!!! MUAHAHHAHAHAHAH
    ledBlinkA();
  } else if (ledIndex == 1) {
    ledBlinkB();
  } else if (ledIndex == 2) {
    ledBlinkC();
  } else if (ledIndex == 3) {
    ledBlinkD();
  } else if (ledIndex == 4) {
    ledBlinkALL();
  }
}



void ledBlinkA() {
   for (int i = 0; i < 5; i++) {
  digitalWrite(ledPinA, HIGH); //set LED pin to HIGH, 3.3V
  delay(ms);  //wait 500 milliseconds
  digitalWrite(ledPinA, LOW);  //set LED pin to LOW, 0V
  delay(ms);  //wait 500 milliseconds
   }
}

void ledBlinkB() {
   for (int i = 0; i < 5; i++) {
  digitalWrite(ledPinB, HIGH); //set LED pin to HIGH, 3.3V
  delay(ms);  //wait 500 milliseconds
  digitalWrite(ledPinB, LOW);  //set LED pin to LOW, 0V
  delay(ms);  //wait 500 milliseconds
   }
}

void ledBlinkC() {
   for (int i = 0; i < 5; i++) {
  digitalWrite(ledPinC, HIGH); //set LED pin to HIGH, 3.3V
  delay(ms);  //wait 500 milliseconds
  digitalWrite(ledPinC, LOW);  //set LED pin to LOW, 0V
  delay(ms);  //wait 500 milliseconds
   }
}


void ledBlinkD() {
   for (int i = 0; i < 5; i++) {
  digitalWrite(ledPinD, HIGH); //set LED pin to HIGH, 3.3V
  delay(ms);  //wait 500 milliseconds
  digitalWrite(ledPinD, LOW);  //set LED pin to LOW, 0V
  delay(ms);  //wait 500 milliseconds
   }
}

void ledBlinkALL() {
   for (int i = 0; i < 10; i++) {
  digitalWrite(ledPinA, HIGH); //set LED pin to HIGH, 3.3V
  digitalWrite(ledPinB, HIGH); //set LED pin to HIGH, 3.3V
  digitalWrite(ledPinC, HIGH); //set LED pin to HIGH, 3.3V
  digitalWrite(ledPinD, HIGH); //set LED pin to HIGH, 3.3V
  delay(ms);  //wait 500 milliseconds
  digitalWrite(ledPinA, LOW);  //set LED pin to LOW, 0V
  digitalWrite(ledPinB, LOW);  //set LED pin to LOW, 0V
  digitalWrite(ledPinC, LOW);  //set LED pin to LOW, 0V
  digitalWrite(ledPinD, LOW);  //set LED pin to LOW, 0V
  delay(ms);  //wait 500 milliseconds
   }
}


