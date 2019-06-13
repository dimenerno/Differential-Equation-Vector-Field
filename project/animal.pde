// Solve the following ODE
// dr/dt = r(a-bw)
// dw/dt = w(cr-d)

float rabbit, wolf;
float a=0.01, b=0.01, c=0.01, d=0.01;
boolean a_first_time=true, a_scale, a_showD, aniOn, showAnimal, showAniProj, a_erased=true, newAni;
AnimalPhase animal;
int a_xgap = 300, a_ygap = 180;

/*
PImage theta_img, theta_dot_img, ode_img, heart_img;
PImage[] pis = new PImage[8];

int maxSize = 32;

Animation ani = new Animation();

float sliderXpos;
boolean locked = false;

float time = 0;

boolean flag = true;
boolean alive = true;
boolean first_time = true;*/

void animal_main() {
  if (a_first_time) {
    redrawAniCanvas();
  }

  if (a_erased) {
    redrawAniCanvas();
    time = 0;
  }

  if (aniOn) {
    plotAnimal();
    if (showAnimal) {
      fill(color(0, 0, 0));
      stroke(color(255, 255, 255));
      rectMode(CORNER);
      rect(10, 10, 300, 300);
      stroke(color(255, 255, 255));
      fill(color(255, 255, 255));
      // TODO: Animal animation code
    }
    if (a_showD) {
      pushMatrix();
      translate(width-330, -100);
      fill(color(0, 0, 0));
      stroke(color(255, 255, 255));
      rectMode(CORNER);
      rect(10, 740, 300, 80);
      fill(color(255, 255, 255));
      textSize(18);
      text("# of Rabbits       " + floor(animal.rabbit*100), 30, 770);
      text("# of Wolves        " + floor(animal.wolf*100), 30, 800);
      popMatrix();
    }
    if (showAniProj) {
      pushMatrix();
      translate(width-430, 100);
      if (newAni) {
        colorMode(RGB);
        stroke(color(255, 255, 255));
        fill(color(0, 0, 0));
        rectMode(CORNER);
        rect(10, 350, 400, 150);
        strokeWeight(2);
        line(40, 370, 40, 480);
        time = 0;
        newAni = false;
      }
      plotRabbitProjGraph();
      plotWolfProjGraph();
      time += 0.5;
      popMatrix();
    }
  }

  drawAniFunctions();  
}


void plotRabbitProjGraph() {
  noStroke();
  fill(#4286f4);
  if (40+time<380) {
    ellipse(40+time, 475-animal.rabbit*20, 2, 2);
  } else newAni = true;
}

void plotWolfProjGraph() {
  noStroke();
  fill(#ff568e);
  if (40+time<380) {
    ellipse(40+time, 475-animal.wolf*20, 2, 2);
  }
}


void redrawAniCanvas() {
  a_erased = false;
  background(0);
  drawAniCoordinate();
  plotPhaseField();
}


void plotPhaseField() {
  for (int i=1; i<=40; i++) {
    for (int j=1; j<=30; j++) {
      float curX = 100+i*60;
      float curY = 1000-j*40;
      rabbit = xtoRabbit(curX);
      wolf = ytoWolf(curY);
      float dR = rabbit*(a-b*wolf);
      float dW = -wolf*(c*rabbit-d);
      float vecX = dR*xgap;
      float vecY = dW*ygap;
      float size = sqrt(vecX*vecX+vecY*vecY)/30;
      colorMode(HSB, 100);
      stroke(map(size, 0, 1.2, 50, 0), 100, 100);
      strokeWeight(2);
      fill(map(size, 0, 1.2, 50, 0), 100, 100);

      if (a_scale)
        drawArrow(curX, curY, curX+vecX/10, curY+vecY/10, 0, 5, true);
      else
        drawArrow(curX, curY, curX+vecX/size, curY+vecY/size, 0, 5, true);
    }
  }
}

// dr/dt = r(a-bw)
// dw/dt = w(cr-d)

void plotAnimal() {
  animal.plot();
  animal.rabbit += 2*animal.rabbit*(a-b*animal.wolf);
  animal.wolf += 2*animal.wolf*(c*animal.rabbit-d);
}


void drawAniFunctions() {
  noStroke();
  colorMode(RGB);
  fill(color(0, 0, 0));
  pushMatrix();
  translate(0, 100);
  rect(width-330, 30, 300, 230);

  stroke(color(255, 255, 255));
  strokeWeight(2);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 150<mouseY && mouseY<170)
    fill(color(40, 40, 40));
  if (a_scale)
    fill(color(255, 255, 255));
  rect(width-310, 50, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 190<mouseY && mouseY<210)
    fill(color(40, 40, 40));
  if (a_showD)
    fill(color(255, 255, 255));
  rect(width-310, 90, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 230<mouseY && mouseY<250)
    fill(color(40, 40, 40));
  if (showAnimal)
    fill(color(255, 255, 255));
  rect(width-310, 130, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 270<mouseY && mouseY<290)
    fill(color(40, 40, 40));
  if (showAniProj)
    fill(color(255, 255, 255));
  rect(width-310, 170, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 310<mouseY && mouseY<330)
    fill(color(40, 40, 40));
  rect(width-310, 210, 20, 20);
  
  
  fill(color(255, 255, 255));
  textSize(18);
  text("Scale by vector size", width-275, 67);
  text("Show dr and dw", width-275, 107);
  text("Show animal animation", width-275, 147);
  text("Show r/w projection graph", width-275, 187);
  text("Apply settings and redraw", width-275, 227);
  popMatrix();

  fill(color(0, 0, 0));
  if (width-230< mouseX && mouseX < width-30 && 30 < mouseY && mouseY < 130) {
    fill(color(60, 60, 60));
    if (mousePressed && mode == 3) {
      a_first_time = true;
      mode = 0;
      aniOn = false;
      return;
    }
  }
  colorMode(RGB);
  stroke(color(255, 255, 255));
  rect(width-230, 30, 200, 70);
  fill(color(255, 255, 255));
  textSize(25);
  textAlign(CENTER, CENTER);
  text("Go back", width-130, 60);
  textAlign(CORNER, CORNER);
}


void drawAniCoordinate() {
  colorMode(RGB);
  for (int i=1; i<=5; i++) {
    stroke(color(50, 50, 50));
    strokeWeight(1);
    line(100+i*a_xgap, 0, 100+i*a_xgap, 1000);
  }
  for (int i=1; i<=5; i++) {
    line(100, 1000-i*a_ygap, width, 1000-i*a_ygap);
  }
  stroke(color(255, 255, 255));
  strokeWeight(4);
  line(0, 1000, width, 1000);
  line(100, 0, 100, height);
}


float xtoRabbit(float x) {
  return (x-100)/a_xgap;
}


float ytoWolf(float y) {
  return -((y-1000)/a_ygap);
}
