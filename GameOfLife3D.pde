final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;

final int CYAN = #00FFFF;
final int ELECTRIC_BLUE = #00C0FF;
final int BLACK = #000000;

final int DELAY = 100;

int cellSize = 5;
float angle = 0;

Grid game;

int gridWidth;
int gridHeight;
int gridDepth;

void setup() {
    size(SCREEN_WIDTH, SCREEN_HEIGHT, P3D);
    background(BLACK);

    gridWidth = width / cellSize / 15;
    // gridHeight = height / cellSize / 15;
    // gridDepth = (gridWidth + gridHeight) / 2;
    gridHeight = gridWidth;
    gridDepth = gridWidth;

    game = new Grid(gridWidth, gridHeight, gridDepth, cellSize, CYAN, ELECTRIC_BLUE, BLACK);

    view();
    game.randomiseGrid();
    game.draw();
}

void view() {
    int centreX = gridWidth / 2 * cellSize;
    int centreY = gridHeight / 2 * cellSize;
    int centreZ = gridDepth / 2 * cellSize;

    int x = centreX;
    int y = centreY;
    int z = centreZ * 3;
    x = z;

    float eyeX = x * cos(angle) + z * sin(angle);
    float eyeY = y;
    float eyeZ = -x * sin(angle) + z * cos(angle);

    camera(eyeX, eyeY, eyeZ, centreX, centreY, centreZ, 0, 1, 0);
    angle = (angle + 0.1) % 360;
}

void draw() {
    try {
        Thread.sleep(DELAY);
    } catch (InterruptedException e) {}

    view();
    // game.update();
    game.draw();
}