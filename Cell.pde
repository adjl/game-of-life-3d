class Cell {

  int x;
  int y;
  int z;
  boolean alive;
  color colour;

  Cell(int x, int y, int z, boolean alive) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.alive = alive;
    colour = 0; // No colour
  }

  boolean isAlive() {
    return alive;
  }

  void live() {
    alive = true;
    colour = generateColour();
  }

  void die() {
    alive = false;
    colour = 0;
  }

  void draw(int size) {
    fill(colour);
    pushMatrix();
    translate(x * size, y * size, z * size);
    box(size);
    popMatrix();
  }

  color generateColour() {
    return color(random(MAX_COLOUR), random(MAX_COLOUR), random(MAX_COLOUR));
  }
}
