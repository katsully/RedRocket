///////////////////////////////////////////
// By: Kat Sullivan
///////////////////////////////////////////

// This is the class for our little red rocket
class Rocket {

  PShape rocket;
  PVector loc;
  ArrayList<Level> levels = new ArrayList<Level>();
  ArrayList<Laser> lasers = new ArrayList<Laser>();
  Iterator<Laser> laserIter;

  Rocket() {
    rocket = createShape();
    rocket.beginShape();
    rocket.fill(255, 0, 0);
    rocket.vertex(10, -20);
    rocket.vertex(10, -10);
    rocket.vertex(20, -10);
    rocket.vertex(20, 10);
    rocket.vertex(-20, 10);
    rocket.vertex(-20, -10);
    rocket.vertex(-10, -10);
    rocket.vertex(-10, -20);
    rocket.endShape();
    loc = new PVector(width/2, height-150);
    levels.add(new Level(1));
  }

  // Display the rocket on screen
  void display(int x, int y) {
    loc.x = x;
    loc.y = y;    

    pushMatrix();
    translate(x, y);
    shape(rocket);
    popMatrix();
    // If the rocket has lasers, fire them
    if (!lasers.isEmpty()) {
      fire();
    }
  }

  // Calls the displayLevel method in the Level class
  void displayScore() {
    levels.get(levels.size()-1).displayLevel();
  }

  // Increment the user's current level
  void newLevel() {
    levels.add(new Level(levels.size()+1));
  }

  // Determine if the laser is still viable (hasn't hit or rock or go off screen)
  boolean shoot(ArrayList<SpaceRock> spaceRocks) {
    float xPosShooting = loc.x;
    float yPosShooting = loc.y-20;
    Laser l = new Laser(xPosShooting, yPosShooting);
    if (newLaser(l)) {
      lasers.add(l);
    }
    if (hasHitTarget(spaceRocks, l)) {
      lasers.remove(l);
      return false;
    }
    if (yPosShooting < 0) {
      lasers.remove(l);
      return false;
    }
    return true;
  }  

  // Determine if laser hit a space rock
  boolean hit(SpaceRock rock) {
    float circleDistanceX = abs(rock.loc.x - loc.x - rocket.width/2);
    float circleDistanceY = abs(rock.loc.y - loc.y - rocket.height/2);

    if (circleDistanceX > (rocket.width/2 + rock.radius)) {
      return false;
    }

    if (circleDistanceY > (rocket.height/2 + rock.radius)) {
      return false;
    }  

    if (circleDistanceX <= rocket.width/2) { 
      return true;
    }
    if (circleDistanceY <= rocket.height/2) {
      return true;
    }

    float cornerDistance_sq = pow(circleDistanceX - rocket.width/2, 2) + pow(circleDistanceY - rocket.height/2, 2);

    if (cornerDistance_sq <= pow(rock.radius, 2)) {
      return true;
    }
    return false;
  }  
  
  // Return player's current level
  int getLevel() {
    return levels.get(levels.size()-1).levelNum;
  }

  // Display all live laser beams
  private void fire() {
    laserIter = lasers.iterator();
    while (laserIter.hasNext ()) {
      Laser laser = laserIter.next();
      laser.fire();
      laser.displayLaser();
      if (hasHitTarget(spaceRocks, laser)) {
        levels.get(levels.size()-1).score++;
        laserIter.remove();
      }
      if (laser.getYPos() < 0) {
        laserIter.remove();
      }
    }
  }

  // Determine if a laser has hit a space rock
  private boolean hasHitTarget(ArrayList<SpaceRock> spaceRocks, Laser laser) {
    iter = spaceRocks.iterator();
    while (iter.hasNext ()) {
      SpaceRock spaceRock = iter.next();
      float circleDistanceX = abs(spaceRock.getXPos() - laser.getXPos() - 2.5);
      float circleDistanceY = abs(spaceRock.getYPos() - laser.getYPos() - 2.5);

      if (circleDistanceX > (2.5 + spaceRock.radius)) {
        continue;
      }

      if (circleDistanceY > (2.5 + spaceRock.radius)) {
        continue;
      }  

      if (circleDistanceX <= 2.5) { 
        iter.remove();
        return true;
      }
      if (circleDistanceY <= 2.5) {
        iter.remove();
        return true;
      }

      float cornerDistance_sq = pow(circleDistanceX - 2.5, 2) + pow(circleDistanceY - 2.5, 2);

      if (cornerDistance_sq <= pow(spaceRock.radius, 2)) {
        iter.remove();
        return true;
      }
    }
    return false;
  }

  private boolean newLaser(Laser l) {
    for (Laser laser : lasers) {
      if (laser.getXPos() == l.getXPos() && laser.getYPos() == l.getYPos()-5) {
        return false;
      }
    }
    return true;
  }
}
