class Tile {
  int x, y;
  int yOffset;
  boolean active; 
  Tile(int x_, int y_, int yOffset) {
    x = x_;
    y = y_;
    this.yOffset = yOffset;
    active = true;
  }

  void setInactive() {
    active = false;
  }

  void display() {
    if (active) {
      rect(x * tileWidth, y * tileHeight + yOffset, tileWidth, tileHeight);
    }
  }
}