private interface CellRunnable {
    void run(int x, int y, int z);
}

private class Grid {

    private final int mWidth;
    private final int mHeight;
    private final int mDepth;
    private final int mCellSize;
    private final int mCentreX;
    private final int mCentreY;
    private final int mCentreZ;
    private final Cell[][][] mCells;

    private float mAngle;

    Grid(int width, int height, int depth, int cellSize, int centreX, int centreY, int centreZ) {
        mWidth = width;
        mHeight = height;
        mDepth = depth;
        mCellSize = cellSize;
        mCentreX = centreX;
        mCentreY = centreY;
        mCentreZ = centreZ;
        mCells = new Cell[depth][height][width];
        initialise();
    }

    private void forEachCell(CellRunnable runnable) {
        for (int z = 0; z < mDepth; z++) {
            for (int y = 0; y < mHeight; y++) {
                for (int x = 0; x < mWidth; x++) {
                    runnable.run(x, y, z);
                }
            }
        }
    }

    private void initialise() {
        forEachCell(new CellRunnable() { // Fill grid with cells
            @Override
            public void run(int x, int y, int z) {
                mCells[z][y][x] = new Cell(x, y, z);
            }
        });
    }

    private int countNeighbours(int x, int y, int z) {
        int neighbours = 0;
        for (int zi = z - 1; zi <= z + 1; zi++) {
            if (zi < 0 || zi >= mDepth) continue;
            for (int yi = y - 1; yi <= y + 1; yi++) {
                if (yi < 0 || yi >= mHeight) continue;
                for (int xi = x - 1; xi <= x + 1; xi++) {
                    if (xi < 0 || xi >= mWidth) continue;
                    else if (xi == x && yi == y && zi == z) continue;
                    else if (mCells[zi][yi][xi].isAlive()) neighbours++;
                }
            }
        }
        return neighbours;
    }

    void setAngle(float angle) {
        mAngle = angle;
    }

    void clear() {
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y, int z) {
                mCells[z][y][x].die();
            }
        });
    }

    void randomise() {
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y, int z) {
                if (int(random(CELL_CHANCE_TO_LIVE)) == 0) {
                    mCells[z][y][x].live();
                } else {
                    mCells[z][y][x].die();
                }
            }
        });
    }

    void update() {
        forEachCell(new CellRunnable() { // Calculate next generation
            @Override
            public void run(int x, int y, int z) {
                mCells[z][y][x].setNeighbours(countNeighbours(x, y, z));
            }
        });
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y, int z) {
                Cell cell = mCells[z][y][x];
                if (cell.isAlive() && cell.getNeighbours() < NEIGHBOUR_MINIMUM) {
                    cell.die(); // Die from underpopulation
                } else if (cell.isAlive() && cell.getNeighbours() > NEIGHBOUR_MAXIMUM) {
                    cell.die(); // Die from overpopulation
                } else if (!cell.isAlive() && cell.getNeighbours() == NEIGHBOUR_REPRODUCTION) {
                    cell.live(); // Live by reproduction
                }
            }
        });
    }

    void draw() {
        background(0);
        pushMatrix();
        rotateY(mAngle);
        translate(-mCentreX, -mCentreY, -mCentreZ); // Centre grid
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y, int z) {
                Cell cell = mCells[z][y][x];
                if (cell.isAlive()) {
                    cell.draw(mCellSize);
                }
            }
        });
        popMatrix();
    }
}
