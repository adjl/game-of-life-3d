final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;

final int MAX_COLOUR = 256;
final int BLACK = #000000;

final float THETA = PI / 180.0;
final int DELAY = 100;

boolean running = false;
float angle = 0.0;

int centreX;
int centreY;
int centreZ;

Grid grid;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P3D);
  background(BLACK);

  int gridWidth = 32;
  int gridHeight = gridWidth;
  int gridDepth = gridWidth;
  int cellSize = 5;

  centreX = gridWidth / 2 * cellSize;
  centreY = gridHeight / 2 * cellSize;
  centreZ = gridDepth / 2 * cellSize;

  camera(0, 0, centreZ * 3, 0, 0, 0, 0, 1, 0);

  grid = new Grid(gridWidth, gridHeight, gridDepth, cellSize);

  lights();

  grid.randomise();
  drawGrid();
}

void draw() {
  lights();

  if (running) grid.update();
  drawGrid();

  try {
    Thread.sleep(DELAY);
  } catch (InterruptedException e) {}
}

void keyPressed() {
  switch (key) {
    case 'p':
      running = !running;
      break;
    case 'r':
      grid.randomise();
      drawGrid();
      break;
    case 'f':
      grid.toggleFill();
      break;
    case 'j':
      angle += THETA;
      break;
    case 'k':
      angle -= THETA;
      break;
  }
}

void drawGrid() {
  pushMatrix();
  rotateY(angle);
  translate(-centreX, -centreY, -centreZ);
  grid.draw();
  popMatrix();
}