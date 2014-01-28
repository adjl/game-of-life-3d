class Cell {

    int x;
    int y;
    int z;
    int size;
    boolean alive;

    Cell(int x, int y, int z, int size, boolean alive) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.size = size;
        this.alive = alive;
    }

    boolean isAlive() {
        return alive;
    }

    void live() {
        alive = true;
    }

    void die() {
        alive = false;
    }

    void draw() {
        pushMatrix();
        translate(x * size, y * size, z * size);
        box(size);
        popMatrix();
    }

}