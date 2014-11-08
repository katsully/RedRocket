///////////////////////////////////////////
// By: Kat Sullivan
///////////////////////////////////////////


import java.util.Iterator;
import processing.serial.*;  // import the Processing serial library

Serial myPort;  // the serial port
boolean firstContact = false;  // used for handshake method when communicating with the Arduino

int xpos, ypos; // starting position
ArrayList<SpaceRock> spaceRocks = new ArrayList<SpaceRock>();
Iterator<SpaceRock> iter;
Rocket redRocket;
boolean shoot, justShot = false;
boolean showScore = false;
int counter = 0;
boolean gameOver = false;  // switches to true when the rocket is hit

// these numbers will increase as you progress through the levels
int numSpaceRocks = 20;
int spaceRockRadius = 20;

void setup() {
  size(800, 600);
  String portName = "COM4";  // you will need to change this to match your port name!
  myPort = new Serial(this, portName, 9600);
  // read incoming bytes to a buffer until you get a linefeed (ASCII 10)
  myPort.bufferUntil('\n');
  redRocket = new Rocket();
  for (int i = 0; i<numSpaceRocks; i++) {
    spaceRocks.add(new SpaceRock((int)random(0, width), (int)random(-600, -50), spaceRockRadius, 1));
  }  
}

void draw() {  
  //background
  background(0);
  
  //show when rocket is hit  
  if(gameOver){
    textSize(100);
    fill(255);
    text("GAME OVER", 100, 100);
    noLoop();
  }
  
  //show score after each level is completed
  if (showScore) {
    redRocket.displayScore();
    if (counter == 300) {
      numSpaceRocks += 10;
      spaceRockRadius += 5;
      for (int i = 0; i<numSpaceRocks; i++) {
        spaceRocks.add(new SpaceRock((int)random(0, width), (int)random(-600, -50), spaceRockRadius, redRocket.getLevel()));
      }
      redRocket.newLevel();
      showScore = false;
      counter = 0;
    }
    counter++;
  }
  
  //draw the rocket
  redRocket.display(xpos, ypos);
  
  //fire available laser beams
  if (shoot && !justShot) {
    redRocket.shoot(spaceRocks);
    shoot = false;
    justShot = true;
  }

  // display all space rocks on screen
  //check if rocket hit by space rock or if rock went off screen
  iter = spaceRocks.iterator();
  while (iter.hasNext ()) {
    SpaceRock r = iter.next();
    r.fall();
    r.displaySpaceRock();
    if (r.getYPos() > height+r.radius) {
      iter.remove();
    }
    if(redRocket.hit(r)){
      gameOver = true;
    }
  }
  
  //check if level is completed
  if (spaceRocks.isEmpty()) {
    showScore = true;    
  }
  delay(1);
}

void serialEvent(Serial myPort) {
  // read the serial buffer
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {

    myString = trim(myString);

    // if you haven't heard from the microcontroller yet, listen
    if (firstContact == false) {
      if (myString.equals("hello")) {
        myPort.clear();        // clear the serial port buffer
        firstContact = true;  // you've had first contact from the microcontroller
        myPort.write('A');     // ask for more
      }
    }
    // if you have heard from the microcontroller, proceed
    else {
      // split the string at the commas and convert the sections into integers
      int sensors[] = int(split(myString, ','));      
      
      if (sensors.length > 1) {
        xpos = (int)map(sensors[0], 0, 1023, 0, width);
        ypos = (int)map(sensors[1], 0, 1023, 0, height);
        if (sensors[2] == 0) {
          shoot = false;
          justShot = false;
        } else {
          shoot = true;
        }
        
      }
    }
    // when you've parsed the data you have, ask for more
    myPort.write("A");
  }
}
