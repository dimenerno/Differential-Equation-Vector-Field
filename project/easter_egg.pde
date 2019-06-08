//circle rad : 8
// square rad : 15

float heartX = 160, heartY = 295, vx = 0, vy = 0, dL = 0, ddL = 0;
float cooltime = 0, alpha = 50;
float HP = 200;
boolean spaceReleased = true;
    
void undertale() {
  rectMode(CENTER);
  stroke(color(255, 255, 255));
  fill(color(0, 0, 0));
  rect(160, 160, 200, 200);
  noStroke();

  heartX += vx;
  heartY -= vy;

  if(heartY > 250) heartY = 250;
  if(heartY < 70) heartY = 70;
  if(heartX < 70) heartX = 70;
  if(heartX > 250) heartX = 250;

  imageMode(CENTER);
  tint(color(255, 255, 255), alpha);
  image(heart_img, heartX, heartY, 20, 20);
  if(L>1.18) {
    L = 1.18;
    dL = -0.01;
    ddL = 0;
  }
  else if(L<=0) { 
    L = 0;
    dL = 0.01;
    ddL = 0;
  }
  L += dL;
  dL += ddL;
  ddL = random(-0.006,0.006);
  
  if(keyPressed) {
    if(keyCode == LEFT)
      vx = -4;
    if(keyCode == RIGHT)
      vx = 4;
    if(keyCode == UP) {
      vy = 4;
    }
    if(keyCode == DOWN) {
      vy = -4;
    }
  }
  else {
    vx = 0;
    vy = 0;
  }
  
  cooltime += 1;
  if(cooltime > 200) {
    alpha = 100;
    heartCollide();
  }
  
  rectMode(CORNER);
  fill(color(255, 255, 0));
  rect(60, 275, HP, 20);
  imageMode(CORNER);
  tint(color(255, 255, 255), 100);
}


void heartCollide() {
  float ballX = 160+(120*L)*sin(obj.theta);
  float ballY = 160+(120*L)*cos(obj.theta);
  if(sqrt((ballX-heartX)*(ballX-heartX)+(ballY-heartY)*(ballY-heartY)) < 23) {
    HP -= 40;
    cooltime = 150;
    alpha = 50;
  }
  if(HP<=0) {
    alive = false;
    HP = 200;
    alpha = 50;
    cooltime = 0;
  }
}
