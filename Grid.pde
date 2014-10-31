private class Grid {

    private final int mWidth;
    private final int mHeight;
    private final int mDepth;
    private final int mCellSize;
    private final Cell[][][] mCells;
    private final Cell[][][] mPrevCells;

    private float mAngle;

    Grid(int width, int height, int depth, int cellSize) {
        mWidth = width;
        mHeight = height;
        mDepth = depth;
        mCellSize = cellSize;
        mCells = new Cell[depth][height][width];
        mPrevCells = new Cell[depth][height][width];
        initialise();
    }

    private void initialise() { // Fill grid with cells
        for (int z = 0; z < mDepth; z++) {
            for (int y = 0; y < mHeight; y++) {
                for (int x = 0; x < mWidth; x++) {
                    mCells[z][y][x] = new Cell(x, y, z);
                }
            }
        }
    }

    private int neighbours(int x, int y, int z) {
        int neighbours = 0;
        for (int zi = z - 1; zi <= z + 1; zi++) {
            if (zi < 0 || zi >= mDepth) {
                continue;
            }
            for (int yi = y - 1; yi <= y + 1; yi++) {
                if (yi < 0 || yi >= mHeight) {
                    continue;
                }
                for (int xi = x - 1; xi <= x + 1; xi++) {
                    if (xi < 0 || xi >= mWidth) {
                        continue;
                    } else if (xi == x && yi == y && zi == z) {
                        continue;
                    } else if (mPrevCells[zi][yi][xi].isAlive()) {
                        neighbours++;
                    }
                }
            }
        }
        return neighbours;
    }

    private boolean isAlive(int x, int y, int z) {
        return mPrevCells[z][y][x].isAlive();
    }

    void setAngle(float angle) {
        mAngle = angle;
    }

    void clear() {
        for (int z = 0; z < mDepth; z++) {
            for (int y = 0; y < mHeight; y++) {
                for (int x = 0; x < mWidth; x++) {
                    mCells[z][y][x].die();
                }
            }
        }
    }

    void randomise() {
        for (int z = 0; z < mDepth; z++) {
            for (int y = 0; y < mHeight; y++) {
                for (int x = 0; x < mWidth; x++) {
                    if (int(random(CELL_CHANCE_TO_LIVE)) == 0) {
                        mCells[z][y][x].live();
                    } else {
                        mCells[z][y][x].die();
                    }
                }
            }
        }
    }

    void update() {
        for (int z = 0; z < mDepth; z++) { // Copy cells to calculate the next generation
            for (int y = 0; y < mHeight; y++) {
                for (int x = 0; x < mWidth; x++) {
                    mPrevCells[z][y][x] = new Cell(x, y, z, mCells[z][y][x].isAlive());
                }
            }
        }
        for (int z = 0; z < mDepth; z++) { // Calculate next generation
            for (int y = 0; y < mHeight; y++) {
                for (int x = 0; x < mWidth; x++) {
                    if (isAlive(x, y, z) && neighbours(x, y, z) < 7) {
                        mCells[z][y][x].die(); // Die of underpopulation
                    } else if (isAlive(x, y, z) && neighbours(x, y, z) > 17) {
                        mCells[z][y][x].die(); // Die of overpopulation
                    } else if (!isAlive(x, y, z) && neighbours(x, y, z) == 8) {
                        mCells[z][y][x].live(); // Live by reproduction
                    }
                }
            }
        }
    }

    void draw() {
        background(#000000); // Draw over previous grid
        pushMatrix();
        rotateY(mAngle);
        translate(-centreX, -centreY, -centreZ); // Centre grid
        for (int z = 0; z < mDepth; z++) {
            for (int y = 0; y < mHeight; y++) {
                for (int x = 0; x < mWidth; x++) {
                    Cell cell = mCells[z][y][x];
                    if (cell.isAlive()) {
                        cell.draw(mCellSize);
                    }
                }
            }
        }
        popMatrix();
    }
}
