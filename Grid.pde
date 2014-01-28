class Grid {

    int width;
    int height;
    int depth;
    int size;

    int colour;
    int highlight;
    int background;

    Cell[][][] oldCells;
    Cell[][][] cells;

    Grid(int width, int height, int depth, int size, int colour, int highlight, int background) {
        this.width = width;
        this.height = height;
        this.depth = depth;
        this.size = size;

        this.colour = colour;
        this.highlight = highlight;
        this.background = background;

        oldCells = new Cell[depth][height][width];
        cells = new Cell[depth][height][width];

        initialiseGrid();
    }

    int getCoordinate(int coordinate) {
        return (max(coordinate - size, -1) + 1) / size;
    }

    void initialiseGrid() {
        for (int z = 0; z < depth; z++) {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    cells[z][y][x] = new Cell(x, y, z, size, false);
                }
            }
        }
    }

    void randomiseGrid() {
        for (int z = 0; z < depth; z++) {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    if (int(random(2)) == 1) {
                        cells[z][y][x].live();
                    } else {
                        cells[z][y][x].die();
                    }
                }
            }
        }
    }

    void copyGrid() {
        for (int z = 0; z < depth; z++) {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    oldCells[z][y][x] = new Cell(x, y, z, size, cells[z][y][x].isAlive());
                }
            }
        }
    }

    void update() {
        copyGrid();
        tick();
    }

    void tick() {
        for (int z = 0; z < depth; z++) {
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    if (alive(x, y, z) && neighbours(x, y, z) < 6) {
                        die(x, y, z);
                    } else if (alive(x, y, z) && neighbours(x, y, z) >= 6 && neighbours(x, y, z) <= 9) {
                        live(x, y, z);
                    } else if (alive(x, y, z) && neighbours(x, y, z) > 9) {
                        die(x, y, z);
                    } else if (dead(x, y, z) && neighbours(x, y, z) == 9) {
                        live(x, y, z);
                    }
                }
            }
        }
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

    boolean alive(int x, int y, int z) {
        return oldCells[z][y][x].isAlive();
    }

    boolean dead(int x, int y, int z) {
        return !oldCells[z][y][x].isAlive();
    }

    void live(int x, int y, int z) {
        cells[z][y][x].live();
    }

    void die(int x, int y, int z) {
        cells[z][y][x].die();
    }

    void highlight(int x, int y, int z) {
        fill(highlight);
        stroke(highlight);
        cells[z][y][x].draw();
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

}