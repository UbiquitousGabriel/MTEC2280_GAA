const int potPinA = 17; // Potentiometer for buzzer frequency
const int potPinB = 18; // Potentiometer for buzzer frequency


int potReadA = 0;
int potReadB = 0;


//software timer variables
int lastTime = 0;
int currentTime = 0;
int timerInterval = 20; //not reliable with values less than 20ms

void setup() {
  // put your setup code here, to run once:

  Serial.begin(115200);
  analogReadResolution(8); //set range from 0-255
}

void loop() {
  // put your main code here, to run repeatedly:


 //we don't want or need to send updates to serial port so often, so use a timer:
  currentTime = millis(); //read current elapsed time
  if (currentTime - lastTime >= timerInterval)  //if we have reached our timer interval...
  {
    lastTime = currentTime; //store current time as last time so we know when timer last occured
     potReadA = analogRead(potPinA);
     //potReadB = analogRead(potPinB); //read sensor and assign to variable called adcRead

  //Serial.print("Pin17 PotA: ");
  Serial.write(potReadA);
  
  //Serial.print("Pin18 PotB: ");
  //Serial.println(potReadB);




  }
  //Serial.write(potReadB)

}
