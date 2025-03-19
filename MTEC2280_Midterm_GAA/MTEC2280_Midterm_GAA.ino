// Code by Gabriel Aguilar


const int ledPinA = 4;
const int ledPinB = 5;
const int ledPinC = 6;
const int ledPinD = 7;
const int potPinA = 18 ; // Potentiometer for LED speed
const int potPinB = 17; // Potentiometer for buzzer frequency
const int buttonPin = 13; // Button for toggling the whole system
const int piezoPin = 21; // Piezo Buzzer
int lightInterval = 10;

bool ledState = false;
bool projectEnabled = true;


int piezoFrequency = 0;

int currentTime = 0;    //variable to store current millis
int previousMillis = 0;  //variable to store millis at moment of last event
int timerInterval = 1000; //amount of milliseconds for comparison

int buttonState = LOW;



void setup() {
  // put your setup code here, to run once:
  pinMode(ledPinA, OUTPUT);
  pinMode(ledPinB, OUTPUT);
  pinMode(ledPinC, OUTPUT);
  pinMode(ledPinD, OUTPUT);

  pinMode(buttonPin, INPUT_PULLUP);
  
  // pinMode(potPinA, INPUT);
  // pinMode(potPinB, INPUT);
  // pinMode(piezoPin, OUTPUT);
  
  // Serial.begin(115200);



}

void loop() {
  // put your main code here, to run repeatedly:
  currentTime = millis();

  //reads the state of the pushbutton value
  buttonState = !digitalRead(buttonPin);

  //
  if (buttonState == LOW){
    projectEnabled = true;
  } else {
    projectEnabled = false;
  }

  //PotentiometerA Controls blink speed
    int potValueA = analogRead(potPinA);
    lightInterval = map(potValueA, 0, 4095, 10, 180);

  //PotentiometerB Controls Piezo Frequency
    int potValueB = analogRead(potPinB);
    piezoFrequency = map(potValueB, 0, 4095, 100, 2000);



if (projectEnabled){
  ledBloom(); 
  piezoSong(); 
  }
}


void ledBloom() {
  for (int i = 0; i < 255; i += lightInterval) {
    analogWrite(ledPinA, i);
    analogWrite(ledPinB, i);
    analogWrite(ledPinC, i);
    analogWrite(ledPinD, i);
    delay(lightInterval);
    Serial.print("FOR LOOP 1: ");
    Serial.println(i);
  }

  for (int i = 255; i > 0; i -= lightInterval) {
    analogWrite(ledPinA, i);
    analogWrite(ledPinB, i);
    analogWrite(ledPinC, i);
    analogWrite(ledPinD, i);
    delay(lightInterval);
    Serial.print("FOR LOOP 2: ");
    Serial.println(i);
  }
}

void piezoSong() {
    tone(piezoPin, piezoFrequency);


    

}






