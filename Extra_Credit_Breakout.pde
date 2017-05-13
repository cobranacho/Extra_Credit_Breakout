int cols = 10;
int rows = 7;
int tileHeight, tileWidth;

Tile[] tiles = new Tile[cols * rows];
Paddle paddle;
Ball ball;

void setup() {
  size(800, 600);

  tileHeight = height / 25;
  tileWidth = width / cols;

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      tiles[i * cols + j] = new Tile(j, i);
    }
  }
  paddle = new Paddle();
  ball = new Ball();
}

void draw() {
  background(0);


  colorMode(HSB, 360, 100, 100); 
  for (int i = 0; i < tiles.length; i++) {
    int x = i / cols;
    fill(360 / 6 * x, 100, 100);
    int currentTileX = tiles[i].x * tileWidth;
    int currentTileY = tiles[i].y * tileHeight;


    if (ball.location.y - ball.radius < currentTileY + tileHeight 
      && ball.location.y + ball.radius > currentTileY
      && ball.location.x + 2 > currentTileX 
      && ball.location.x  - 2 < currentTileX + tileWidth
      && tiles[i].active == true) {

      tiles[i].active = false;
      ball.velocity.y *= -1;
    } else if (ball.location.x + ball.radius > currentTileX
      && ball.location.x - ball.radius < currentTileX + tileWidth
      && ball.location.y + 2 > currentTileY
      && ball.location.y - 2 < currentTileY + tileHeight
      && tiles[i].active == true) {

      tiles[i].active = false;
      ball.velocity.x *= -1;
    }
    tiles[i].display();
  }
  ball.update();
  paddle.update();
}


class Tile {
  int x, y;
  boolean active; 
  Tile(int x_, int y_) {
    x = x_;
    y = y_;
    active = true;
  }

  void setInactive() {
    active = false;
  }

  void display() {

    if (active) {
      rect(x * tileWidth, y * tileHeight, tileWidth, tileHeight);
    }
  }
}

class Paddle {
  int x, y;
  int paddleWidth, paddleHeight;
  Paddle() {
    paddleWidth = width / 10;
    paddleHeight = height / 32;
    x = (width / 2) - paddleWidth;
    y = (height - height / 10);
  }
  void decreasePaddle() {
    paddleWidth -= 10;
  }
  void update() {
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == LEFT && x > 0) {
          x = x - 4;
        } else if (keyCode == RIGHT && x + paddleWidth < width) {
          x = x + 4;
        }
      }
    }
    display();
  }
  void display() {
    fill(100, 38, 150);
    rect(x, y, paddleWidth, paddleHeight);
  }
}
class Ball {
  PVector location;
  PVector velocity;
  int radius;
  boolean outOfBound;
  boolean contact;

  Ball() {

    location = new PVector(random(100, width - 100), rows * tileHeight + 50);
    velocity = new PVector(random(-6, 6), 4);
    radius = height / 70;
    outOfBound = false;
  }

  void update() {
    if (location.x + radius >= width || location.x - radius <= 0) {
      velocity.x *= -1;
    } else if (location.y - radius <= 0 || location.y + radius >= height) {
      velocity.y *= -1;
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