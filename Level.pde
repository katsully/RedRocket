///////////////////////////////////////////
// By: Kat Sullivan
///////////////////////////////////////////

// This class represents each level of the game
class Level {

  int levelNum;
  int score;

  Level(int levelNum) {
    this.levelNum = levelNum;
    score=0;
  }

  // Display player's current level and score
  void displayLevel() {
    textSize(50);
    fill(255);
    String s = "LEVEL: " + levelNum + "\t SCORE: " + score;    
    text(s, 100, 100);
  }
}
