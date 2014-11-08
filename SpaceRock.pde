///////////////////////////////////////////
// By: Kat Sullivan
///////////////////////////////////////////

// This class represents a space rock
class SpaceRock {

  PVector loc;
  PVector velocity;
  int radius;  

  SpaceRock(int tempXPos, int tempYPos, int tempRadius, int tempFallRate) {
    loc = new PVector(tempXPos, tempYPos);
    velocity = new PVector(0,tempFallRate);
    radius = tempRadius;    
  }

  // Display the space rock on screen
  void displaySpaceRock() {
    noStroke();
    fill(0, 255, 0); 
    textSize(60);
    ellipse(loc.x, loc.y, radius, radius);
  }

  // Increment the y position of the rock to simulate "falling"
  void fall() {
    loc.add(velocity);
  }
  
  // Return the x position of the rock
  float getXPos() {
    return loc.x;
  }
  
  // Return the y position of the rock
  float getYPos() {
    return loc.y;
  }
}
