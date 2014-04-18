class Cell {

  final int MAX_COLOUR_VALUE = 256;

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
    colour = 0; // No colour
  }

  boolean isAlive() {
    return alive;
  }

  void live() {
    alive = true;
    colour = generateRandomColour();
  }

  void die() {
    alive = false;
    colour = 0;
  }

  void draw() {
    fill(colour);
    pushMatrix();
    translate(x * size, y * size, z * size);
    box(size);
    popMatrix();
  }

  color generateRandomColour() {
    return color(random(MAX_COLOUR_VALUE), random(MAX_COLOUR_VALUE), random(MAX_COLOUR_VALUE));
  }
}