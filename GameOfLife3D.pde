private static final float RADIAN = PI / 180.0;
private static final int ANIMATION_DELAY = 100;
private static final int GRID_WIDTH = 32;
private static final int GRID_HEIGHT = 32;
private static final int GRID_DEPTH = 32;
private static final int CELL_CHANCE_TO_LIVE = 5;
private static final int CELL_SIZE = 5;
private static final int NEIGHBOUR_MAXIMUM = 17;
private static final int NEIGHBOUR_MINIMUM = 7;
private static final int NEIGHBOUR_REPRODUCTIVE = 8;

private Grid mGrid;
private boolean mRunning;
private float mAngle;
private float mZoom;
private int mCentreZ;

@Override
void setup() {
    size(displayWidth, displayHeight, P3D);
    noStroke();

    final int centreX = GRID_WIDTH / 2 * CELL_SIZE;
    final int centreY = GRID_HEIGHT / 2 * CELL_SIZE;
    mCentreZ = GRID_DEPTH / 2 * CELL_SIZE;
    mZoom = RADIAN * 180.0;
    zoomCamera();

    mGrid = new GridBuilder().setWidth(GRID_WIDTH).setHeight(GRID_HEIGHT).setDepth(GRID_DEPTH)
            .setCellSize(CELL_SIZE).setCentreX(centreX).setCentreY(centreY).setCentreZ(mCentreZ)
            .build();
    mGrid.randomise();
}

@Override
void draw() {
    lights();

    if (mRunning) {
        mGrid.update();
    }
    mGrid.draw();

    try {
        Thread.sleep(ANIMATION_DELAY);
    } catch (InterruptedException e) {}
}

@Override
void keyPressed() {
    switch (key) {
        case 'p': // Resume/pause
            mRunning = !mRunning;
            break;
        case 'c': // Clear mGrid
            mGrid.clear();
            mGrid.draw();
            break;
        case 'r': // Randomise mGrid
            mGrid.randomise();
            mGrid.draw();
            break;
        case 'j': // Rotate left
            mAngle -= RADIAN;
            mGrid.setAngle(mAngle);
            break;
        case 'k': // Rotate right
            mAngle += RADIAN;
            mGrid.setAngle(mAngle);
            break;
        case 'h': // Zoom in
            mZoom -= RADIAN;
            zoomCamera();
            break;
        case 'l': // Zoom out
            mZoom += RADIAN;
            zoomCamera();
            break;
        case 'q': // Quit
            exit();
            break;
    }
}

private void zoomCamera() {
    camera(0, 0, mCentreZ * mZoom, 0, 0, 0, 0, 1, 0);
}
