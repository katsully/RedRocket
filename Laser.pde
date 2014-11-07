///////////////////////////////////////////
// By: Kat Sullivan
///////////////////////////////////////////

// This class represents a single laser beam shot from the rocket
class Laser{
  
  PVector loc;
  PVector velocity;
  
  Laser(float tempXPos, float tempYPos) {
    loc = new PVector(tempXPos, tempYPos);
    velocity = new PVector(0,5);
  }
  
  // show the laser on the screen
  void displayLaser() {
    fill(255,0,0);
    rect(loc.x, loc.y, 5, 5);
  }
  
  // decrease the y position of the laser to simulate "shooting"
  void fire() {
    loc.sub(velocity);
  }
  
  // return the x position of the laser beam
  float getXPos() {
    return loc.x;
  }
  
  // return the y position of the laser beam
  float getYPos() {
    return loc.y;
  }
  
}
