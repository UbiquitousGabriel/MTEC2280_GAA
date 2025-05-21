//Gabriel Aguilar's Final project for MTEC 2280 
// "Rainman"

//Pot Variables
const int potPin_1 = 1; 
const int potPin_2 = 2;
int potRead_1 = 0;
int potRead_2 = 0;

void setup() {
  analogReadResolution(10);     // Set analog resolution to 0-1023
  Serial.begin(115200);         // Start serial communication
}

void loop() {

  potRead_1 = analogRead(potPin_1);
  potRead_2 = analogRead(potPin_2);

  Serial.print(potRead_1);
  Serial.print(',');
  Serial.println(potRead_2);

  delay(100); // Slow it down so it’s readable in Serial Monitor
}


