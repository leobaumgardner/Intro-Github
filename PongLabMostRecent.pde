int paddleWidth = 150;
int paddleHeight = 10;
int paddleY = 0;
int ballSize = 20;
int ballX = 0;
int ballY = 0;
int ballSpeed = 3;
int ballSpeedIncrease = 1;
int ballXDirection = 1;
int ballYDirection = -1;
int score = 0;
boolean crazyRainbow = false;
boolean gameOver = false;

void setup() {
  size(640, 360);
  paddleY = height - paddleHeight - 30;
  ballX = int(random(ballSize, width - ballSize));
  ballY = int(random(ballSize, height / 2));
}

void draw() {
  if (gameOver) {
    background(0);
    fill(255);
    textAlign(CENTER);
    text("Game Over. Press any key to start over.", width/2, height/2);
  } else {
    background(0);
    if (crazyRainbow) {
      fill(random(255), random(255), random(255));
    } else {
      fill(255);
    }
    textAlign(RIGHT);
    textSize(32);
    text("Score: " + score, width - 20, 40);

    // Move paddle
    int paddleX = constrain(mouseX - paddleWidth / 2, 0, width - paddleWidth);
    rect(paddleX, paddleY, paddleWidth, paddleHeight);

    // Move ball
    fill(random(255), random(255), random(255));
    ellipse(ballX, ballY, ballSize, ballSize);
    ballX += ballSpeed * ballXDirection;
    ballY += ballSpeed * ballYDirection;

    // Check for wall collisions
    if (ballX - ballSize/2 <= 0 || ballX + ballSize/2 >= width) {
      ballXDirection *= -1;
    }
    if (ballY - ballSize/2 <= 0) {
      ballYDirection *= -1;
    }

    // Check for paddle collision
    if (ballY + ballSize/2 >= paddleY && ballX >= paddleX && ballX <= paddleX + paddleWidth) {
      ballYDirection *= -1;
      ballSpeed += ballSpeedIncrease;
      score++;
    }

    // Check for game over
    if (ballY - ballSize/2 >= height) {
      gameOver = true;
    }
  }
}

void keyPressed() {
  if (gameOver) {
    score = 0;
    ballSpeed = 5;
    ballXDirection = random(2) == 0 ? 1 : -1;
    ballYDirection = -1;
    ballX = int(random(ballSize, width - ballSize));
    ballY = int(random(ballSize, height / 2));
    gameOver = false;
  }
}

void mousePressed() {
  crazyRainbow = true;
}

void mouseReleased() {
  crazyRainbow = false;
}
