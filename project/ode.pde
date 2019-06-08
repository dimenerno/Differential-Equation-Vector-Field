
// Solve the following ODE
// [theta, theta_dot] = [theta_dot, -mu*theta_dot-(g/L)sin(theta)]
// TODO: Make a window that shows object's theta and omega

float dt = 0.0001, theta, theta_dot;
float mu = 0, g = -9.8, L = 1;

PImage theta_img, theta_dot_img, ode_img, heart_img;
PImage[] pis = new PImage[8];

int xgap=200, ygap=150;
int maxSize = 32;

boolean scale, showD, objOn, showPendulum, showProj, gameOn, erased = true, newObj;

Animation ani = new Animation();
Pendulum obj;

float sliderXpos;
boolean locked = false;

float time = 0;

boolean flag = true;
boolean alive = true;
boolean first_time = true;

void ode_main() {

  if (first_time) {
    redrawCanvas();
  }

  if (erased) {
    redrawCanvas();
    time = 0;
    alive = true;
    L = 1;
  }

  if (objOn) {
    plotPendulum();
    if (showPendulum) {
      fill(color(0, 0, 0));
      stroke(color(255, 255, 255));
      rectMode(CORNER);
      rect(10, 10, 300, 300);
      if (gameOn && alive) undertale();
      stroke(color(255, 255, 255));
      fill(color(255, 255, 255));
      line(160, 160, 160+(120*L)*sin(obj.theta), 160+(120*L)*cos(obj.theta));
      ellipse(160+(120*L)*sin(obj.theta), 160+(120*L)*cos(obj.theta), 16, 16);
    }
    if (showD) {
      fill(color(0, 0, 0));
      stroke(color(255, 255, 255));
      rectMode(CORNER);
      rect(10, 740, 300, 80);
      fill(color(255, 255, 255));
      textSize(18);
      text("θ(rad)\t       " + (obj.theta), 30, 770);
      text("ω(rad/s)\t   " + (obj.theta_dot), 30, 800);
    }
    if (showProj) {
      if (newObj) {
        colorMode(RGB);
        stroke(color(255, 255, 255));
        fill(color(0, 0, 0));
        rectMode(CORNER);
        rect(10, 350, 400, 150);
        rect(10, 520, 400, 150);
        strokeWeight(2);
        line(40, 370, 40, 480);
        line(40, 425, 380, 425);
        line(40, 540, 40, 650);
        line(40, 595, 380, 595);
        time = 0;
        newObj = false;
      }
      plotXProjGraph();
      plotYProjGraph();
      time += 0.5;
    }
  }

  drawFunctions();  
  drawSlider();
}


void plotXProjGraph() {
  noStroke();
  fill(color(255, 255, 255));
  if (40+time<380) {
    ellipse(40+time, 425+45*sin(obj.theta), 2, 2);
  } else newObj = true;
}

void plotYProjGraph() {
  noStroke();
  if (40+time<380) {
    ellipse(40+time, 595+45*cos(obj.theta), 2, 2);
  }
}


void redrawCanvas() {
  erased = false;
  background(0);
  drawCoordinate();
  plotODE();
}


void drawSlider() {
  line(width-330, height-120, width-70, height-120);
  rectMode(CENTER);
  fill(color(255, 255, 255));
  rect(sliderXpos, height-120, 10, 30);
  rectMode(CORNER);
}


void plotODE() {
  float L = 1;
  for (int i=-17; i<=17; i++) {
    for (int j=-15; j<=15; j++) {
      float curX = width/2+i*60;
      float curY = height/2+j*40;
      theta = xtoTheta(curX);
      theta_dot = ytoThetadot(curY);
      float dX = theta_dot;
      float dY = -mu*theta_dot-(g/L)*sin(theta);
      float vecX = dX/(PI/2)*xgap;
      float vecY = dY/2*ygap;
      float size = sqrt(vecX*vecX+vecY*vecY)/30;
      colorMode(HSB, 100);
      stroke(map(size, 0, maxSize, 50, 0), 100, 100);
      strokeWeight(2);
      fill(map(size, 0, maxSize, 50, 0), 100, 100);

      if (scale)
        drawArrow(curX, curY, curX+vecX/10, curY+vecY/10, 0, 5, true);
      else
        drawArrow(curX, curY, curX+vecX/size, curY+vecY/size, 0, 5, true);
    }
  }
  drawEquation();
}


void plotPendulum() {
  float L = 1;
  obj.plot();
  obj.theta += obj.theta_dot/70;
  obj.theta_dot -= (-mu*obj.theta_dot-(g/L)*sin(obj.theta))/70;
}


void drawEquation() {
  PImage ode = loadImage("ode.png");
  ode.resize(600, 0);
  noStroke();
  fill(color(0, 0, 0, 70));
  rect(30, height-200, 650, 130);
  image(ode, 40, height-190);
}



void drawFunctions() {
  noStroke();
  colorMode(RGB);
  fill(color(0, 0, 0));
  pushMatrix();
  translate(0, 100);
  rect(width-330, 30, 300, 280);
  rect(width-350, height-190, 330, 120);

  stroke(color(255, 255, 255));
  strokeWeight(2);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 150<mouseY && mouseY<170)
    fill(color(40, 40, 40));
  if (scale)
    fill(color(255, 255, 255));
  rect(width-310, 50, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 190<mouseY && mouseY<210)
    fill(color(40, 40, 40));
  if (showD)
    fill(color(255, 255, 255));
  rect(width-310, 90, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 230<mouseY && mouseY<250)
    fill(color(40, 40, 40));
  if (showPendulum)
    fill(color(255, 255, 255));
  rect(width-310, 130, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 270<mouseY && mouseY<290)
    fill(color(40, 40, 40));
  if (showProj)
    fill(color(255, 255, 255));
  rect(width-310, 170, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 310<mouseY && mouseY<330)
    fill(color(40, 40, 40));
  rect(width-310, 210, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 350<mouseY && mouseY<370)
    fill(color(40, 40, 40));
  if (gameOn)
    fill(color(255, 255, 255));
  rect(width-310, 250, 20, 20);

  fill(color(255, 255, 255));
  textSize(18);
  text("Scale by vector size", width-275, 67);
  text("Show dθ and dω", width-275, 107);
  text("Show pendulum animation", width-275, 147);
  text("Show x/y projection graph", width-275, 187);
  text("Apply settings and redraw", width-275, 227);
  text("Pendulundertale", width-275, 267);
  text("Air drag coefficient(Slide slowly!!)", width-330, height-160);
  popMatrix();

  fill(color(0, 0, 0));
  if (width-230< mouseX && mouseX < width-30 && 30 < mouseY && mouseY < 130) {
    fill(color(60, 60, 60));
    if (mousePressed && mode == 1) {
      first_time = true;
      mode = 0;
      objOn = false;
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




void drawCoordinate() {
  colorMode(RGB);
  for (int i=1; i<=4; i++) {
    stroke(color(50, 50, 50));
    strokeWeight(1);
    line(width/2+i*xgap, 0, width/2+i*xgap, height);
    image(pis[2*(i-1)], width/2+i*xgap+20, height/2+25, pis[2*(i-1)].width/3, pis[2*(i-1)].height/3);
    line(width/2-i*xgap, 0, width/2-i*xgap, height);
    image(pis[2*(i-1)+1], width/2-i*xgap+20, height/2+25, pis[2*(i-1)+1].width/3, pis[2*(i-1)+1].height/3);
  }
  for (int i=1; i<=3; i++) {
    line(0, height/2+i*ygap, width, height/2+i*ygap);
    line(0, height/2-i*ygap, width, height/2-i*ygap);
  }
  stroke(color(255, 255, 255));
  strokeWeight(4);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  image(theta_img, width-110, height/2-70, 80, 53.12);
  image(theta_dot_img, width/2+30, 20, 80, 69.12);
}


float xtoTheta(float x) {
  return ((x-width/2)/xgap)*PI/2;
}


float ytoThetadot(float y) {
  return -((y-height/2)/ygap)*2;
}
