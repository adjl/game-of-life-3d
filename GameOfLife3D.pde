final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;

final int CYAN = #00FFFF;
final int ELECTRIC_BLUE = #00C0FF;
final int BLACK = #000000;

final int DELAY = 200;

float angle = 0.0;

int centreX;
int centreY;
int centreZ;

Grid grid;

void setup() {
    size(SCREEN_WIDTH, SCREEN_HEIGHT, P3D);
    background(BLACK);

    int cellSize = 5;

    int gridWidth = width / cellSize / 15;
    int gridHeight = gridWidth;
    int gridDepth = gridWidth;

    centreX = gridWidth / 2 * cellSize;
    centreY = gridHeight / 2 * cellSize;
    centreZ = gridDepth / 2 * cellSize;

    int eyeX = centreX * 2;
    int eyeY = centreY;
    int eyeZ = centreZ * 2;

    camera(eyeX, eyeY, eyeZ, centreX, centreY, centreZ, 0, 1, 0);

    grid = new Grid(gridWidth, gridHeight, gridDepth, cellSize, CYAN, ELECTRIC_BLUE, BLACK);

    grid.randomise();
    drawGrid();
}

void draw() {
    grid.update();
    drawGrid();

    try {
        Thread.sleep(DELAY);
    } catch (InterruptedException e) {}
}

void drawGrid() {
    pushMatrix();
    rotateY(angle);
    translate(-centreX, 0, -centreZ);
    grid.draw();
    popMatrix();

    angle += PI / 180.0;
}