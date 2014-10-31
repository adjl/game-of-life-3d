private static final float RADIAN = PI / 180.0;
private static final int ANIMATION_DELAY = 100;
private static final int GRID_WIDTH = 32;
private static final int GRID_HEIGHT = 32;
private static final int GRID_DEPTH = 32;
private static final int CELL_SIZE = 5;
private static final int CELL_CHANCE_TO_LIVE = 5;

private Grid grid;
private boolean running;
private float angle;
private float zoom;
private int centreX;
private int centreY;
private int centreZ;

@Override
void setup() {
    zoom = RADIAN * 180.0;
    centreX = GRID_WIDTH / 2 * CELL_SIZE;
    centreY = GRID_HEIGHT / 2 * CELL_SIZE;
    centreZ = GRID_DEPTH / 2 * CELL_SIZE;

    size(displayWidth, displayHeight, P3D);
    noStroke();
    zoomCamera();
    grid = new Grid(GRID_WIDTH, GRID_HEIGHT, GRID_DEPTH, CELL_SIZE);
    grid.randomise();
}

@Override
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

@Override
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
            zoomCamera();
            break;
        case 'l': // Zoom out
            zoom += RADIAN;
            zoomCamera();
            break;
        case 'q': // Quit
            exit();
            break;
    }
}

private void zoomCamera() {
    camera(0, 0, centreZ * zoom, 0, 0, 0, 0, 1, 0);
}
