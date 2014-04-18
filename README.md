# Game of Life 3D
A 3D implementation of Conway's Game of Life in Processing.

![First screenshot of GameOfLife3D](https://github.com/adeijosol/GameOfLife3D/raw/master/screenshot1.png)
![Second screenshot of GameOfLife3D](https://github.com/adeijosol/GameOfLife3D/raw/master/screenshot2.png)

## Controls
`p` - Resume/pause the simulation  
`c` - Clear the grid  
`r` - Randomise the grid (generate a new seed)  
`j` - Rotate the camera left around the grid  
`k` - Rotate the camera right around the grid  
`q` - Quit

## Parameters
Modify the following in [`GameOfLife3D.pde`](https://github.com/adeijosol/GameOfLife3D/raw/master/GameOfLife3D.pde) to your preferences:
- `SCREEN_WIDTH` (default: 1366)
- `SCREEN_HEIGHT` (defaul: 768)
- `ANIMATION_DELAY` (default: 100)
- `GRID_WIDTH` (default: 32)
- `GRID_HEIGHT` (default: 32)
- `GRID_DEPTH` (default: 32)
- `CELL_SIZE` (default: 5)
- `CELL_PROBABILITY_TO_LIVE` (default: 5)
  - Relevant only when randomising the grid
  - Must be greater than 0
  - 1 = 100%, 2 = 50%, 4 = 25%, etc.

## Rules
- Live cells with less than 7 neighbours die of underpopulation.
- Live cells with more than 17 neighbours die of overpopulation.
- Dead cells with 8 neighbours live by reproduction.
- Live cells with 7 to 17 neighbours, inclusive, live on to the next generation.

The current rules result in a mostly full grid. These are clearly ineffective, and will be continually refined.

## Notes
- The simulation starts with a random seed.
- Flashes of random background colours occur occasionally.

## License
[MIT License](https://github.com/adeijosol/GameOfLife3D/raw/master/LICENSE)
