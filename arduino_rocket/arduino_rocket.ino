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

//void loop() {
//  int analogValue = analogRead(A0)/4;
//  Serial.println(analogValue);
//  
//  // print different formats:
//  Serial.write(analogValue);  // print the raw binary value
//  Serial.print('\t');         // print a tab
//  // print the ASCII-encoded values:
//  Serial.print(analogValue, BIN);  // print ASCII-encoded binary value
//  Serial.print('\t');              // print a tab
//  Serial.print(analogValue);       // print decimal value
//  Serial.print('\t');              // print a tab
//  Serial.print(analogValue, HEX);  // print hexidecimal value
//  Serial.print('\t');              // print a tab
//  Serial.print(analogValue, OCT);  // print octal value
//  Serial.println();                // print linefeed & carriage return  
//}

void loop() {
  if (Serial.available() > 0) {
    // read the incoming byte
    int inByte = Serial.read();
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

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("hello");  // send a starting message
    delay(300);
  }
}



