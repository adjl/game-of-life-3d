private class Cell {

    private static final int MAX_COLOUR = 256;

    private final int mX;
    private final int mY;
    private final int mZ;

    private boolean mAlive;
    private color mColour;

    Cell(int x, int y, int z) {
        mX = x;
        mY = y;
        mZ = z;
    }

    Cell(int x, int y, int z, boolean alive) {
        this(x, y, z);
        mAlive = alive;
    }

    private color generateColour() {
        return color(random(MAX_COLOUR), random(MAX_COLOUR), random(MAX_COLOUR));
    }

    boolean isAlive() {
        return mAlive;
    }

    void live() {
        mAlive = true;
        mColour = generateColour();
    }

    void die() {
        mAlive = false;
        mColour = 0;
    }

    void draw(int size) {
        fill(mColour);
        pushMatrix();
        translate(mX * size, mY * size, mZ * size);
        box(size);
        popMatrix();
    }
}
