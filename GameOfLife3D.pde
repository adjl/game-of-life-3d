final int ANIMATION_DELAY = 100;
final int GRID_WIDTH = 32;
final int GRID_HEIGHT = 32;
final int GRID_DEPTH = 32;
final int CELL_SIZE = 5;
final int CELL_CHANCE_TO_LIVE = 5;
final float RADIAN = PI / 180.0;

boolean running;
float angle;
float zoom;
int centreX;
int centreY;
int centreZ;

Grid grid;

void setup() {
  running = false;
  angle = 0.0;
  zoom = RADIAN * 180;
  centreX = GRID_WIDTH / 2 * CELL_SIZE;
  centreY = GRID_HEIGHT / 2 * CELL_SIZE;
  centreZ = GRID_DEPTH / 2 * CELL_SIZE;

  size(displayWidth, displayHeight, P3D);
  noStroke();
  camera(0, 0, centreZ * zoom, 0, 0, 0, 0, 1, 0);
  grid = new Grid(GRID_WIDTH, GRID_HEIGHT, GRID_DEPTH, CELL_SIZE);
  grid.randomise();
}

void draw() {
  lights();

  if (running) {
    grid.update();
  }
  grid.draw();

  try {
    Thread.sleep(ANIMATION_DELAY);
  } catch (InterruptedException e) {
  }
}

void keyPressed() {
  switch (key) {
    case 'p': // Resume/pause
      running = !running;
      break;
    case 'c': // Clear grid
      grid.clear();
      grid.draw();
      break;
    case 'r': // Randomise grid
      grid.randomise();
      grid.draw();
      break;
    case 'j': // Rotate left
      angle -= RADIAN;
      grid.setAngle(angle);
      break;
    case 'k': // Rotate right
      angle += RADIAN;
      grid.setAngle(angle);
      break;
    case 'h': // Zoom in
      zoom -= RADIAN;
      camera(0, 0, centreZ * zoom, 0, 0, 0, 0, 1, 0);
      break;
    case 'l': // Zoom out
      zoom += RADIAN;
      camera(0, 0, centreZ * zoom, 0, 0, 0, 0, 1, 0);
      break;
    case 'q': // Quit
      exit();
      break;
  }
}
