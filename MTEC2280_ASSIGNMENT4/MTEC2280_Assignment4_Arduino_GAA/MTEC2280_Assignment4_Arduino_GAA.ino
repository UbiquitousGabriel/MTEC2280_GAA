const int potPinA = 17; // Potentiometer for buzzer frequency
const int potPinB = 18; // Potentiometer for buzzer frequency
const int buttonPinA = 13; //Button for something
const int buttonPinB = 14; //Button for something

//Potentiometer Variables
int potReadA = 0;
int potReadB = 0;

//Button Variables
int buttonStateA = 0;
int buttonStateB = 0;

//software timer variables
int lastTime = 0;
int currentTime = 0;  //Pokorny
int timerInterval = 20; //not reliable with values less than 20ms

void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPinA, INPUT_PULLUP);
  pinMode(buttonPinB, INPUT_PULLUP);

  Serial.begin(115200);
  analogReadResolution(8); //set range from 0-255
}

void loop() {
  //map ADC read from 0 to 255 range into -128 to 127 range
  //Processing handles bytes as -128 to 127 range, so we need to adjust
  potReadA = map(analogRead(potPinA), 0, 255, -128, 127);
  potReadB = map(analogRead(potPinB), 0, 255, -128, 127);

  //read button state on pins [NOTE: logic is inverted due to Pullup config]
  buttonStateA = !digitalRead(buttonPinA);
  buttonStateB = !digitalRead(buttonPinB);

 //we don't want or need to send updates to serial port so often, so use a timer:
  currentTime = millis(); //read current elapsed time
  if (currentTime - lastTime >= timerInterval)  //if we have reached our timer interval...  //pokorny
  {
    lastTime = currentTime; //store current time as last time so we know when timer last occured

//Send Data to Processing via Serial UART
  //Serial.print("Pin17 PotA: ");
  Serial.write(potReadA);
  //Serial.print("Pin18 PotB: ");
  Serial.write(potReadB);
  Serial.write(buttonStateA);
  Serial.write(buttonStateB);
  Serial.write('e');
  }

  
  //Serial.write(potReadB)

}
