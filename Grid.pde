class Grid {

  final color BLACK = color(0, 0, 0);

  int width;
  int height;
  int depth;
  int cellSize;
  Cell[][][] previousCells;
  Cell[][][] cells;

  Grid(int width, int height, int depth, int cellSize) {
    this.width = width;
    this.height = height;
    this.depth = depth;
    this.cellSize = cellSize;
    previousCells = new Cell[depth][height][width];
    cells = new Cell[depth][height][width];

    initialise();
  }

  void initialise() { // Fill grid with cells
    for (int i = 0; i < depth; i++) {
      final int z = i; // To reference z within the inner class
      (new Thread() {
        public void run() {
          for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
              cells[z][y][x] = new Cell(x, y, z, cellSize, false);
            }
          }
        }
      }).start();
    }
  }

  void clear() {
    for (int i = 0; i < depth; i++) {
      final int z = i;
      (new Thread() {
        public void run() {
          for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
              cells[z][y][x].die();
            }
          }
        }
      }).start();
    }
  }

  void randomise() {
    for (int i = 0; i < depth; i++) {
      final int z = i;
      (new Thread() {
        public void run() {
          for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
              if (int(random(CELL_PROBABILITY_TO_LIVE)) == 0) cells[z][y][x].live();
              else cells[z][y][x].die();
            }
          }
        }
      }).start();
    }
  }

  void update() {
    for (int i = 0; i < depth; i++) { // Copy cells to purely calculate the next generation
      final int z = i;
      (new Thread() {
        public void run() {
          for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
              previousCells[z][y][x] = new Cell(x, y, z, cellSize, cells[z][y][x].isAlive());
            }
          }
        }
      }).start();
    }

    for (int z = 0; z < depth; z++) { // Calculate next generation
      (new TickThread(z)).start();
    }
  }

  void draw() {
    pushMatrix();
    rotateY(angle);
    translate(-centreX, -centreY, -centreZ); // TODO What is this for?
    background(BLACK); // Draw over previous grid
    for (int z = 0; z < depth; z++) { // NOTE Cannot multithread cell drawing
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          Cell cell = cells[z][y][x];
          if (cell.isAlive()) cell.draw();
        }
      }
    }
    popMatrix();
  }


  class TickThread extends Thread {

    int z;

    TickThread(int z) {
      this.z = z;
    }

    void run() {
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          if (isAlive(x, y, z) && neighbours(x, y, z) < 7) {
            cells[z][y][x].die(); // Die of underpopulation
          } else if (isAlive(x, y, z) && neighbours(x, y, z) > 17) {
            cells[z][y][x].die(); // Die of overpopulation
          } else if (!isAlive(x, y, z) && neighbours(x, y, z) == 8) {
            cells[z][y][x].live(); // Live by reproduction
          }
        }
      }
    }

    boolean isAlive(int x, int y, int z) {
      return previousCells[z][y][x].isAlive();
    }

    int neighbours(int x, int y, int z) {
      int neighbours = 0;

      for (int zi = z - 1; zi <= z + 1; zi++) { // NOTE Wrapping does not work due to multithreading
        if (zi < 0 || zi >= depth) continue;
        for (int yi = y - 1; yi <= y + 1; yi++) {
          if (yi < 0 || yi >= height) continue;
          for (int xi = x - 1; xi <= x + 1; xi++) {
            if (xi < 0 || xi >= width) continue;
            if (xi == x && yi == y && zi == z) continue;
            if (previousCells[zi][yi][xi].isAlive()) neighbours++;
          }
        }
      }

      return neighbours;
    }
  }
}