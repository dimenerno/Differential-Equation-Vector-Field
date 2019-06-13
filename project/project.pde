PImage main, about;
int mode = 0;
void setup() {
  fullScreen();
  //size(1920, 1080);
  sliderXpos = width-200;

  theta_img = loadImage("theta.png");
  theta_dot_img = loadImage("theta_dot.png");
  ode_img = loadImage("ode.png");
  pis[0] = loadImage("pi2.png");
  pis[1] = loadImage("-pi2.png");
  pis[2] = loadImage("pi.png");
  pis[3] = loadImage("-pi.png");
  pis[4] = loadImage("3pi2.png");
  pis[5] = loadImage("-3pi2.png");
  pis[6] = loadImage("2pi.png");
  pis[7] = loadImage("-2pi.png");
  heart_img = loadImage("heart.png");
  main = loadImage("main.png");
  about = loadImage("about.png");
}


void draw() {
  if (mode == 0) {
    image(main, 0, 0);
    if (192 < mouseX && mouseX < 192+842 && 668 < mouseY && mouseY < 668+51) {
      triangle(130, 676, 130, 711, 160, 693);
      if (mousePressed) mode = 1;
    }
    if (192 < mouseX && mouseX < 192+883 && 753.58 < mouseY && mouseY < 753.58+51) {
      translate(0, 85.58);
      triangle(130, 676, 130, 711, 160, 693);
      if (mousePressed) mode = 2;
    }
    if (192 < mouseX && mouseX < 192+386 && 839.17 < mouseY && mouseY < 839.17+51) {
      translate(0, 85.58*2);
      triangle(130, 676, 130, 711, 160, 693);
      if (mousePressed) mode = 3;
    }
    if (192 < mouseX && mouseX < 192+123.82 && 919.29 < mouseY && mouseY < 919.29+51) {
      translate(0, 85.58*3);
      triangle(130, 676, 130, 711, 160, 693);
      if (mousePressed) mode = 4;
    }
  }
  if (mode == 1) {
    ode_main();
  }
  if (mode == 2) {
    body_main();
  }
  if (mode == 3) {
    animal_main();
  }
  if (mode == 4) {
    image(about, 0, 0);
    fill(color(0, 0, 0));
    if (width-230< mouseX && mouseX < width-30 && 30 < mouseY && mouseY < 130) {
      fill(color(60, 60, 60));
      if (mousePressed && mode == 4) {
        mode = 0;
      }
    }
    stroke(color(255, 255, 255));
    rect(width-230, 30, 200, 70);
    fill(color(255, 255, 255));
    textSize(25);
    textAlign(CENTER, CENTER);
    text("Go back", width-130, 60);

    textAlign(CORNER, CORNER);
    rectMode(CORNER);
    noStroke();
  }
}

void underDevelopment(int _mode) {
  fill(color(0, 0, 0));
  rect(0, 0, width, height);
  textAlign(CENTER, CENTER);
  fill(color(255, 255, 255));
  textSize(50);
  text("Under Development!", width/2, height/2);

  rectMode(CENTER);
  fill(color(0, 0, 0));
  if (width/2-100< mouseX && mouseX < width/2+100 && height/2+100-35 < mouseY && mouseY < height/2+100+35) {
    fill(color(60, 60, 60));
    if (mousePressed && mode == _mode) {
      mode = 0;
    }
  }
  stroke(color(255, 255, 255));
  rect(width/2, height/2+100, 200, 70);
  fill(color(255, 255, 255));
  textSize(25);
  text("Go back", width/2, height/2+95);

  textAlign(CORNER, CORNER);
  rectMode(CORNER);
  noStroke();
}
