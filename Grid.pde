class Grid {

    int width;
    int height;
    int depth;
    int cellSize;

    int colour;
    int highlight;
    int background;

    Cell[][][] oldCells;
    Cell[][][] cells;

    Grid(int width, int height, int depth, int cellSize, int colour, int highlight, int background) {
        this.width = width;
        this.height = height;
        this.depth = depth;
        this.cellSize = cellSize;

        this.colour = colour;
        this.highlight = highlight;
        this.background = background;

        oldCells = new Cell[depth][height][width];
        cells = new Cell[depth][height][width];

        initialise();
    }

    void initialise() {
        for (int z = 0; z < depth; z++) {
            (new InitialiseThread(z)).start();
        }
    }

    void randomise() {
        for (int z = 0; z < depth; z++) {
            (new RandomiseThread(z)).start();
        }
    }

    void copy() {
        for (int z = 0; z < depth; z++) {
            (new CopyThread(z)).start();
        }
    }

    void tick() {
        for (int z = 0; z < depth; z++) {
            (new TickThread(z)).start();
        }
    }

    void update() {
        copy();
        tick();
    }

    void draw() {
        noFill();
        stroke(colour);
        background(background);

        for (int z = 0; z < depth; z++) {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    Cell cell = cells[z][y][x];
                    if (cell.isAlive()) cell.draw();
                }
            }
        }
    }

    class InitialiseThread extends Thread {

        int z;

        InitialiseThread(int z) {
            this.z = z;
        }

        void run() {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    cells[z][y][x] = new Cell(x, y, z, cellSize, false);
                }
            }
        }

    }

    class RandomiseThread extends Thread {

        int z;

        RandomiseThread(int z) {
            this.z = z;
        }

        void run() {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    if (int(random(2)) == 1) cells[z][y][x].live();
                    else cells[z][y][x].die();
                }
            }
        }

    }

    class CopyThread extends Thread {

        int z;

        CopyThread(int z) {
            this.z = z;
        }

        void run() {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    oldCells[z][y][x] = new Cell(x, y, z, cellSize, cells[z][y][x].isAlive());
                }
            }
        }

    }

    class TickThread extends Thread {

        int z;

        TickThread(int z) {
            this.z = z;
        }

        void run() {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    if (isAlive(x, y, z) && neighbours(x, y, z) < 6) {
                        die(x, y, z);
                    } else if (isAlive(x, y, z) && neighbours(x, y, z) >= 6 && neighbours(x, y, z) <= 9) {
                        live(x, y, z);
                    } else if (isAlive(x, y, z) && neighbours(x, y, z) > 9) {
                        die(x, y, z);
                    } else if (!isAlive(x, y, z) && neighbours(x, y, z) == 9) {
                        live(x, y, z);
                    }
                }
            }
        }

        boolean isAlive(int x, int y, int z) {
            return oldCells[z][y][x].isAlive();
        }

        int neighbours(int x, int y, int z) {
            int neighbours = 0;

            for (int zi = z - 1; zi <= z + 1; zi++) {
                if (zi < 0 || zi >= depth) continue;
                for (int yi = y - 1; yi <= y + 1; yi++) {
                    if (yi < 0 || yi >= height) continue;
                    for (int xi = x - 1; xi <= x + 1; xi++) {
                        if (xi < 0 || xi >= width) continue;
                        if (xi == x && yi == y && zi == z) continue;
                        if (oldCells[zi][yi][xi].isAlive()) neighbours++;
                    }
                }
            }

            return neighbours;
        }

        void live(int x, int y, int z) {
            cells[z][y][x].live();
        }

        void die(int x, int y, int z) {
            cells[z][y][x].die();
        }

    }

}