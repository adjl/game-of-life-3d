class Grid {

  int width;
  int height;
  int depth;
  int cellSize;
  float angle;
  Cell[][][] cells;
  Cell[][][] prevCells;

  Grid(int width, int height, int depth, int cellSize) {
    this.width = width;
    this.height = height;
    this.depth = depth;
    this.cellSize = cellSize;
    angle = 0.0;
    cells = new Cell[depth][height][width];
    prevCells = new Cell[depth][height][width];

    initialise();
  }

  void setAngle(float angle) {
    this.angle = angle;
  }

  void initialise() { // Fill grid with cells
    for (int z = 0; z < depth; z++) {
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          cells[z][y][x] = new Cell(x, y, z, false);
        }
      }
    }
  }

  void clear() {
    for (int z = 0; z < depth; z++) {
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          cells[z][y][x].die();
        }
      }
    }
  }

  void randomise() {
    for (int z = 0; z < depth; z++) {
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          if (int(random(CELL_CHANCE_TO_LIVE)) == 0) {
            cells[z][y][x].live();
          } else {
            cells[z][y][x].die();
          }
        }
      }
    }
  }

  void update() {
    for (int z = 0; z < depth; z++) { // Copy cells to calculate the next generation
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          prevCells[z][y][x] = new Cell(x, y, z, cells[z][y][x].isAlive());
        }
      }
    }

    for (int z = 0; z < depth; z++) { // Calculate next generation
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
  }

  boolean isAlive(int x, int y, int z) {
    return prevCells[z][y][x].isAlive();
  }

  int neighbours(int x, int y, int z) {
    int neighbours = 0;

    for (int zi = z - 1; zi <= z + 1; zi++) {
      if (zi < 0 || zi >= depth) {
        continue;
      }
      for (int yi = y - 1; yi <= y + 1; yi++) {
        if (yi < 0 || yi >= height) {
          continue;
        }
        for (int xi = x - 1; xi <= x + 1; xi++) {
          if (xi < 0 || xi >= width) {
            continue;
          } else if (xi == x && yi == y && zi == z) {
            continue;
          } else if (prevCells[zi][yi][xi].isAlive()) {
            neighbours++;
          }
        }
      }
    }

    return neighbours;
  }

  void draw() {
    background(#000000); // Draw over previous grid
    pushMatrix();
    rotateY(angle);
    translate(-centreX, -centreY, -centreZ); // Centre grid
    for (int z = 0; z < depth; z++) {
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          Cell cell = cells[z][y][x];
          if (cell.isAlive()) {
            cell.draw(cellSize);
          }
        }
      }
    }
    popMatrix();
  }
}
