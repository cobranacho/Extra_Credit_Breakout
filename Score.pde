
class Score {
  int theScore;
  int theLevel;
  int balls;
  int x, y; 
  Number ones, tens, hundreds, thousands, level, ballsCount;
  
  Score(int x, int y, int score, int initlevel, int balls) {
    this.x = x;
    this.y = y;
    theScore = score;
    theLevel = initlevel;
    this.balls = balls;
    thousands = new Number(x, y, 0.7);
    hundreds = new Number(x + width / 20, y, 0.7);
    tens = new Number(x + width / 20 * 2, y, 0.7);
    ones = new Number(x + width / 20 * 3, y, 0.7);
    level = new Number(int(width / 1.5), y, 0.7);
    ballsCount = new Number(int(width / 1.2), y, 0.7);
  }
  
  void reset(){
    theScore = 0;
        
  }
  
  
  void addToScore(int num) {
    theScore += num;
  }
  
  void increaseLevel() {
    theLevel++;
    if (theLevel > 10) {
      theLevel = 1;
    }
    paddle.decreasePaddle(theLevel);
  }
  
  void reduceBallCount() {
    balls--;
    if (balls == 0) {
      gameOver = true;
    }
  }
  
  int getBallCount() {
    return balls;
  }
  
  int getScore() {
    return theScore; 
  }
  
  void displayScore() {
    int onesDigit;
    int tensDigit;
    int hundredsDigit;
    int thousandsDigit;
    
    thousandsDigit = theScore / 1000;
    hundredsDigit = (theScore - thousandsDigit * 1000) / 100;
    tensDigit = (theScore - thousandsDigit * 1000 - hundredsDigit * 100) / 10;
    onesDigit = theScore % 10;
    
    thousands.setNumber(thousandsDigit);
    hundreds.setNumber(hundredsDigit);
    tens.setNumber(tensDigit);
    ones.setNumber(onesDigit);
    
    thousands.display();
    hundreds.display();
    tens.display();
    ones.display();
    
    level.setNumber(theLevel);
    level.display();
    ballsCount.setNumber(balls);
    ballsCount.display();
    
  }

  
}