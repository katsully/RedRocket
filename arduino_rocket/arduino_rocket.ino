////////////////////////////////
// By: Kat Sullivan
////////////////////////////////

const int digitalOne = 2;  // digital input
int counter = 0;
int avgSensorOne = 0;
int avgSensorTwo = 0;
int avgButton = 0;

void setup() {
  Serial.begin(9600);
  pinMode(digitalOne, INPUT);
  establishContact();
}

void loop() {
  if (Serial.available() > 0) {
    // read the incoming byte
    int inByte = Serial.read();
    // take the average of the next 30 reads and send that value
    // to Processing to create a more fluid motion
    for(int i=0; i<30; i++){
      int sensorValue = analogRead(A0);
      avgSensorOne += sensorValue;
      sensorValue = analogRead(A1);
      avgSensorTwo += sensorValue;
      sensorValue = digitalRead(digitalOne);
      avgButton += sensorValue;
    }    
    Serial.print(avgSensorOne/30);
    Serial.print(",");
    delay(1);
    Serial.print(avgSensorTwo/30);
    Serial.print(",");
    delay(1);
    Serial.println(avgButton/30);
    delay(1);

    avgSensorOne = 0;
    avgSensorTwo = 0;    
    avgButton = 0;
  }
}

// Used for the handshake method with Processing
void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("hello");  // send a starting message
    delay(300);
  }
}



