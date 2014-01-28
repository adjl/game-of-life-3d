final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;

final int BLACK = #000000;
final int WHITE = #FFFFFF;

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

    int cellSize = 5;

    int gridWidth = 32;
    int gridHeight = gridWidth;
    int gridDepth = gridWidth;

    centreX = gridWidth / 2 * cellSize;
    centreY = gridHeight / 2 * cellSize;
    centreZ = gridDepth / 2 * cellSize;

    int eyeX = centreX * 3;
    int eyeY = centreY;
    int eyeZ = centreZ * 3;

    camera(eyeX, eyeY, eyeZ, centreX, centreY, centreZ, 0, 1, 0);

    grid = new Grid(gridWidth, gridHeight, gridDepth, cellSize);

    grid.randomise();
    drawGrid();
}

void draw() {
    if (running) grid.update();
    drawGrid();

    try {
        Thread.sleep(DELAY);
    } catch (InterruptedException e) {}
}

void keyPressed() {
    switch (key) {
        case 'r':
            running = !running;
            break;
        case 'f':
            grid.toggleFill();
            break;
        case 'j':
            angle -= THETA;
            break;
        case 'k':
            angle += THETA;
            break;
    }
}

void drawGrid() {
    pushMatrix();
    rotateY(angle);
    translate(-centreX, 0, -centreZ);
    grid.draw();
    popMatrix();
}