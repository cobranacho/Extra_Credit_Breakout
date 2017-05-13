
class Paddle {
  int x, y;
  int paddleWidth, paddleHeight;
  Paddle() {
    paddleWidth = width / 6;
    paddleHeight = height / 32;
    x = (width / 2) - paddleWidth;
    y = (height - height / 10);
  }
  void decreasePaddle(int currentLevel) {
    if (currentLevel == 1) {
      paddleWidth = width / 10;
      x += paddleWidth / 10 / 2;
    } else {
      paddleWidth -= paddleWidth / 8;
      x += paddleWidth / 6 / 2;
    }
  }
  void update() {
    if (!gameOver) {
      if (keyPressed) {
        if (key == CODED) {
          if (keyCode == LEFT && x > 0) {
            x = x - width / 80;
          } else if (keyCode == RIGHT && x + paddleWidth < width) {
            x = x + width / 80;
          }
        } else if (key == 'b') {
          scoreBoard.increaseLevel();
        }
      }
    }
  }
  void display() {
    fill(100, 38, 150);
    rect(x, y, paddleWidth, paddleHeight);
  }
}