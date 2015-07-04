private class GridBuilder {

    private int mWidth;
    private int mHeight;
    private int mDepth;
    private int mCellSize;
    private int mCentreX;
    private int mCentreY;
    private int mCentreZ;

    GridBuilder setWidth(int width) {
        mWidth = width;
        return this;
    }

    GridBuilder setHeight(int height) {
        mHeight = height;
        return this;
    }

    GridBuilder setDepth(int depth) {
        mDepth = depth;
        return this;
    }

    GridBuilder setCellSize(int cellSize) {
        mCellSize = cellSize;
        return this;
    }

    GridBuilder setCentreX(int centreX) {
        mCentreX = centreX;
        return this;
    }

    GridBuilder setCentreY(int centreY) {
        mCentreY = centreY;
        return this;
    }

    GridBuilder setCentreZ(int centreZ) {
        mCentreZ = centreZ;
        return this;
    }

    Grid build() {
        return new Grid(mWidth, mHeight, mDepth, mCellSize, mCentreX, mCentreY, mCentreZ);
    }
}
