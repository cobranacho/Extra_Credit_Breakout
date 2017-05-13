class Ball {
  PVector location;
  PVector velocity;
  int radius;

  Ball() {

    radius = height / 70;
    ballReset();
  }

  void ballReset() {
    location = new PVector(random(width / 6, width * 5 /6), rows * tileHeight + scoreBoardHeight + 50);
    velocity = new PVector(random(-3, 3), 3);
    if (velocity.x == 0) {
      velocity.x = -2;
    }
  }

  
  void increaseVelocity() {
    if (abs(velocity.y) < 7.0) {
      velocity.mult(1.05);
    }
  }

  void update() {
    if (location.x + radius >= width || location.x - radius <= 0) {
      velocity.x *= -1;
    } else if (location.y - radius <= scoreBoardHeight) {
      velocity.y *= -1;
    } else if (location.y - radius > height + height / 4) {
      scoreBoard.reduceBallCount();
      if (!gameOver) {
        ballReset();
      }
    }
    if  (location.x + 2 > paddle.x 
      && location.x - 2 < paddle.x + paddle.paddleWidth 
      && location.y + radius > paddle.y
      && location.y - radius < paddle.y + paddle.paddleHeight) { 
      velocity.y *= -1;
    } else if (location.y + radius + 2 > paddle.y
      && location.y - radius - 2 < paddle.y + paddle.paddleHeight
      && location.x + radius > paddle.x
      && location.x - radius < paddle.x + paddle.paddleWidth) {
      velocity.x *= -1;
    }
    location.add(velocity);
    display();
  }

  void display() {
    fill(255);
    ellipse(location.x, location.y, radius * 2, radius * 2);
  }
}