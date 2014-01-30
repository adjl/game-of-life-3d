class Cell {

  int x;
  int y;
  int z;
  int size;
  boolean alive;

  color colour;

  Cell(int x, int y, int z, int size, boolean alive) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.size = size;
    this.alive = alive;

    colour = BLACK;
  }

  boolean isAlive() {
    return alive;
  }

  void live() {
    alive = true;
    if (colour == BLACK) colour = color(random(MAX_COLOUR), random(MAX_COLOUR), random(MAX_COLOUR));
  }

  void die() {
    alive = false;
    colour = BLACK;
  }

  void draw(boolean filled) {
    if (filled) {
      noStroke();
      fill(colour);
    } else {
      stroke(colour);
      noFill();
    }

    pushMatrix();
    translate(x * size, y * size, z * size);
    box(size);
    popMatrix();
  }

}