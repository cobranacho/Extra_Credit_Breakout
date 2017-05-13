int cols = 10;
int rows = 6;
int tileHeight, tileWidth;
int scoreBoardHeight;
Score scoreBoard;

int tilesActive;
boolean gameOver;
Tile[] tiles = new Tile[cols * rows];
Paddle paddle;
Ball ball;
int balls = 3;

void setup() {
  size(800, 600);
  noCursor();
  resetGame();
}



void resetGame() {

  gameOver = false;
  scoreBoardHeight = height / 10;
  scoreBoard = new Score(width / 10, scoreBoardHeight / 8, 0, 1, balls);

  initializeTiles();
  paddle = new Paddle();
  ball = new Ball();
}
void initializeTiles() {
  tilesActive = cols * rows;
  tileHeight = height / 30;
  tileWidth = width / cols;

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      tiles[i * cols + j] = new Tile(j, i, scoreBoardHeight);
    }
  }
}
void draw() {
  background(0);

  if (!gameOver) {
    colorMode(HSB, 360, 100, 100); 
    for (int i = 0; i < tiles.length; i++) {
      int x = i / cols;
      fill(360 / 6 * x, 100, 100);
      stroke(10, 10, 10);
      strokeWeight(1);
      int currentTileX = tiles[i].x * tileWidth;
      int currentTileY = tiles[i].y * tileHeight + scoreBoardHeight;

      if (ball.location.y - ball.radius < currentTileY + tileHeight 
        && ball.location.y + ball.radius > currentTileY
        && ball.location.x + 2 > currentTileX 
        && ball.location.x  - 2 < currentTileX + tileWidth
        && tiles[i].active == true) {
        scoreBoard.addToScore(rows - tiles[i].y);  
        tiles[i].active = false;
        tilesActive--;
        ball.velocity.y *= -1;
        ball.increaseVelocity();
      } else if (ball.location.x + ball.radius > currentTileX
        && ball.location.x - ball.radius < currentTileX + tileWidth
        && ball.location.y + 2 > currentTileY
        && ball.location.y - 2 < currentTileY + tileHeight
        && tiles[i].active == true) {
        scoreBoard.addToScore(rows - tiles[i].y);   
        tiles[i].active = false;
        tilesActive--;
        ball.velocity.x *= -1;
        ball.increaseVelocity();
      }
      if (tilesActive == 0) {
        initializeTiles();
        scoreBoard.increaseLevel();
        ball.ballReset();
      }
      tiles[i].display();
    }
    ball.update();
    paddle.update();
    paddle.display();
    scoreBoard.displayScore();
  } else {
    scoreBoard.displayScore();
    stroke(10, 10, 10);
    strokeWeight(1);
    paddle.display();
    for (int i = 0; i < tiles.length; i++) {
      int x = i / cols;
      fill(360 / 6 * x, 100, 100);
      tiles[i].display();
    }
    displayGameOver();
  }


  if (gameOver && keyPressed) {

    if (key == CODED) {
      if (keyCode == DOWN) {
        resetGame();
      }
    }
  }
}
void displayGameOver() {
  fill(255);
  textSize(width / 16);
  textAlign(CENTER);
  text("GAME OVER", width / 2, height / 2.5 + scoreBoardHeight);
  textSize(width/ 28);
  fill(255, (frameCount % 125) * 2);
  text("PRESS DOWN ARROW KEY TO PLAY AGAIN", width / 2, height / 2 + height / 3.5);
}