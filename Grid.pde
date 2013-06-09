class Grid {

    int width;
    int height;
    int size;

    int colour;
    int highlight;
    int background;

    Cell[][] oldCells;
    Cell[][] cells;

    Grid(int width, int height, int size, int colour, int highlight, int background) {
        this.width = width / size;
        this.height = height / size;
        this.size = size;

        this.colour = colour;
        this.highlight = highlight;
        this.background = background;

        oldCells = new Cell[height][width];
        cells = new Cell[height][width];

        initialiseGrid();
    }

    int getCoordinate(int coordinate) {
        return (max(coordinate - size, -1) + 1) / size;
    }

    void initialiseGrid() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                cells[y][x] = new Cell(x, y, size, false);
            }
        }
    }

    void randomiseGrid() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (int(random(2)) == 1) {
                    cells[y][x].live();
                } else {
                    cells[y][x].die();
                }
            }
        }
    }

    void copyGrid() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                oldCells[y][x] = new Cell(x, y, size, cells[y][x].isAlive());
            }
        }
    }

    void update() {
        copyGrid();
        tick();
    }

    void tick() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (alive(x, y) && neighbours(x, y) < 2) {
                    die(x, y);
                } else if (alive(x, y) && (neighbours(x, y) == 2 || neighbours(x, y) == 3)) {
                    live(x, y);
                } else if (alive(x, y) && neighbours(x, y) > 3) {
                    die(x, y);
                } else if (dead(x, y) && neighbours(x, y) == 3) {
                    live(x, y);
                }
            }
        }
    }

    int neighbours(int x, int y) {
        int neighbours = 0;

        for (int yi = y - 1; yi <= y + 1; yi++) {
            if (yi < 0 || yi >= height) continue;
            for (int xi = x - 1; xi <= x + 1; xi++) {
                if (xi < 0 || xi >= width) continue;
                if (xi == x && yi == y) continue;
                if (oldCells[yi][xi].isAlive()) neighbours++;
            }
        }

        return neighbours;
    }

    boolean alive(int x, int y) {
        return oldCells[y][x].isAlive();
    }

    boolean dead(int x, int y) {
        return !oldCells[y][x].isAlive();
    }

    void live(int x, int y) {
        cells[y][x].live();
    }

    void die(int x, int y) {
        cells[y][x].die();
    }

    void highlight(int x, int y) {
        fill(highlight);
        stroke(highlight);
        cells[y][x].draw();
    }

    void draw() {
        noFill();
        stroke(colour);
        background(background);

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                Cell cell = cells[y][x];
                if (cell.isAlive()) cell.draw();
            }
        }
    }

}
