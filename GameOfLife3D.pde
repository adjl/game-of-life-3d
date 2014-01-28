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

int centreX;
int centreY;
int centreZ;

void setup() {
    size(SCREEN_WIDTH, SCREEN_HEIGHT, P3D);
    background(BLACK);

    gridWidth = width / cellSize / 15;
    // gridHeight = height / cellSize / 15;
    // gridDepth = (gridWidth + gridHeight) / 2;
    gridHeight = gridWidth;
    gridDepth = gridWidth;

    centreX = gridWidth / 2 * cellSize;
    centreY = gridHeight / 2 * cellSize;
    centreZ = gridDepth / 2 * cellSize;

    int eyeX = centreZ * 3;
    int eyeY = centreY;
    int eyeZ = centreZ * 3;

    camera(eyeX, eyeY, eyeZ, centreX, centreY, centreZ, 0, 1, 0);

    game = new Grid(gridWidth, gridHeight, gridDepth, cellSize, CYAN, ELECTRIC_BLUE, BLACK);

    game.randomiseGrid();

    pushMatrix();
    rotateY(angle);
    translate(-centreX, 0, -centreZ);
    game.draw();
    popMatrix();

    stroke(#FF0000);
    pushMatrix();
    translate(centreX, centreY, centreZ);
    box(cellSize);
    popMatrix();

    angle += PI / 180;
}

void draw() {
    // game.update();

    pushMatrix();
    rotateY(angle);
    translate(-centreX, 0, -centreZ);
    game.draw();
    popMatrix();

    stroke(#FF0000);
    pushMatrix();
    translate(centreX, centreY, centreZ);
    box(cellSize);
    popMatrix();

    angle += PI / 180;
}