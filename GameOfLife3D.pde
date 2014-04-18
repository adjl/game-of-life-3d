// Modify these as preferred:
// --------------------------
final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;
final int ANIMATION_DELAY = 100;
final int GRID_WIDTH = 32;
final int GRID_HEIGHT = 32;
final int GRID_DEPTH = 32;
final int CELL_SIZE = 5;
final int CELL_PROBABILITY_TO_LIVE = 5;
// --------------------------


final float RADIAN = PI / 180.0;

boolean simulationIsRunning = false;
float cameraAngle = 0.0;
float zoomLevel = RADIAN * 175;

int centreX;
int centreY;
int centreZ;
Grid grid;


void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P3D);
  noStroke();

  centreX = GRID_WIDTH / 2 * CELL_SIZE;
  centreY = GRID_HEIGHT / 2 * CELL_SIZE;
  centreZ = GRID_DEPTH / 2 * CELL_SIZE;

  camera(0, 0, centreZ * zoomLevel, 0, 0, 0, 0, 1, 0);

  grid = new Grid(GRID_WIDTH, GRID_HEIGHT, GRID_DEPTH, CELL_SIZE);
  grid.randomise();
}

void draw() {
  lights();

  if (simulationIsRunning) grid.update();
  grid.draw();

  try {
    Thread.sleep(ANIMATION_DELAY);
  } catch (InterruptedException e) {}
}

void keyPressed() {
  switch (key) {
    case 'p': // Resume/pause simulation
      simulationIsRunning = !simulationIsRunning;
      break;
    case 'c': // Clear grid
      grid.clear();
      grid.draw();
      break;
    case 'r': // Randomise grid
      grid.randomise();
      grid.draw();
      break;
    case 'j': // Rotate camera left
      cameraAngle += RADIAN;
      break;
    case 'k': // Rotate camera right
      cameraAngle -= RADIAN;
      break;
    case 'h': // Zoom in
      zoomLevel -= RADIAN;
      camera(0, 0, centreZ * zoomLevel, 0, 0, 0, 0, 1, 0);
      break;
    case 'l': // Zoom out
      zoomLevel += RADIAN;
      camera(0, 0, centreZ * zoomLevel, 0, 0, 0, 0, 1, 0);
      break;
    case 'q': // Quit
      exit();
      break;
  }
}