int[][] grid;
int N = 500;
int xSize, ySize, rectSize;
int vx = 0, vy = 0;
int headX = 0, headY = 0, snakeLength = 1;
int tempLength;
int direction, nextDirection;

void setup() {
	frameRate(10);
	size(N, N);
	/* Size of a piece of the grid and a single member of the snake */
	rectSize = 10;
	/* Size of the grid */
	xSize = N/rectSize;
	ySize = N/rectSize;
	/* Initialize and complete grid */
	grid = new int[xSize][ySize];
	for (int x = 0; x < xSize; ++x) {
		for (int y = 0; y < ySize; ++y) {
			grid[x][y] = 0;
		}
	}
	grid[headX][headY] = 1;
	randomTreat();
	randomTreat();
}

void draw() {
	background(50);
	
	/* Move forward */
	headX += vx;
	headY += vy;
	/* Check the head square position */
	if (headX < 0 || headY < 0) {
		println("Game Over");
		exit();
	} else if (headX >= xSize || headY >= ySize) {
		println("Game Over");
		exit();
	}
	/* Quit game if you run into yourself */
	else if ((vx != 0 || vy != 0) && grid[headX][headY] > 0) {
		println("Game Over");
		exit();
	} else {
		/* Find out if you got a treat */
		if (grid[headX][headY] < 0) {
			snakeLength++;
			randomTreat();
		}
		grid[headX][headY] = snakeLength;
	}

	
	

	/* Draw the body of the snake */
	for (int x = 0; x < xSize; ++x) {
		for (int y = 0; y < ySize; ++y) {
			if (grid[x][y] > 0 && grid[x][y] <= snakeLength) {
				fill(255);
				rect(x * rectSize, y * rectSize, rectSize, rectSize);
				// ellipse(x * rectSize, y * rectSize, rectSize, rectSize);
				grid[x][y]--;
			}

			/* Display the treat */
			if (grid[x][y] < 0) {
				fill(255, 0, 0);
				rect(x * rectSize, y * rectSize, rectSize, rectSize);
			}
		}
	}

}

/** Sets a random location in the grid to be a treat */
void randomTreat() {
	int randX = (int)random(0, xSize);
	int randY = (int)random(0, ySize);
	if (grid[randX][randY] == 0) {
		grid[randX][randY] = -1;
	} else {
		randomTreat();
	}
}

void keyPressed() {
	if (key == CODED) {
		switch (keyCode) {
			case DOWN:
				if (vy == 0) {
					vx = 0;
					vy = 1;
				}
				break;
			case UP:
				if (vy == 0) {
					vx = 0;
					vy = -1;
				}
				break;
				
			case LEFT:
				if (vx == 0) {
					vx = -1;
					vy = 0;
				}
				break;
				
			case  RIGHT:
				if (vx == 0) {
					vx = 1;
					vy = 0;
				}
				break;
		}
	}
}

