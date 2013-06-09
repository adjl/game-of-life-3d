final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;

final int CYAN = #00FFFF;
final int ELECTRIC_BLUE = #00C0FF;
final int BLACK = #000000;

final int DELAY = 100;

int cellSize = 5;

Grid game;
boolean running;

void setup() {
    size(SCREEN_WIDTH, SCREEN_HEIGHT);
    background(BLACK);
    pause();

    game = new Grid(width, height, cellSize, CYAN, ELECTRIC_BLUE, BLACK);
}

void play() {
    running = true;
}

void pause() {
    running = false;
}

void keyPressed() {
    switch (key) {
        case ENTER:
        case RETURN:
            if (running) pause();
            else play();
            break;
        case BACKSPACE:
            if (!running) {
                game.randomiseGrid();
                game.draw();
            }
            break;
    }
}

void mouseMoved() {
    if (!running) {
        int x = game.getCoordinate(mouseX);
        int y = game.getCoordinate(mouseY);

        game.draw();
        game.highlight(x, y);
    }
}

void mousePressed() {
    if (!running) {
        int x = game.getCoordinate(mouseX);
        int y = game.getCoordinate(mouseY);

        switch (mouseButton) {
            case LEFT:
                game.live(x, y);
                break;
            case RIGHT:
                game.die(x, y);
                break;
        }

        game.draw();
        game.highlight(x, y);
    }
}

void draw() {
    if (running) {
        try {
            Thread.sleep(DELAY);
        } catch (InterruptedException e) {}

        game.update();
        game.draw();
    }
}
