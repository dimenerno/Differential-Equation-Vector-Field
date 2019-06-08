
// Solve the following ODE
// [theta, theta_dot] = [theta_dot, -mu*theta_dot-(g/L)sin(theta)]
// TODO: Make a window that shows object's theta and omega

body[] bodies = new body[50];
float[] dvxdt = new float[50];
float[] dvydt = new float[50];
boolean bodyFirstTime = true, neg_charge=false, start=false;
float G = 50;
int numObj = 0;

void body_main() {
  background(#000000);

  for (int i=0; i<numObj; i++)
    bodies[i].drawBody();
  if (oddity%3 == 1 && start) {
    bodyInteract();
    
  }

  plotGravODE();
      drawGravFunctions();
}

// [x, dx/dt] = [dx/dt, -m1(x-x1)/r1^3 - m_2(x-x2)/r2^3

void bodyInteract() {
  float r;

  for (int i=0; i<numObj; i++) {
    dvxdt[i] = 0;
    dvydt[i] = 0;
    for (int j=(i+1)%numObj; j!=i; j=(j+1)%numObj) {
      r = dist(bodies[i].x, bodies[i].y, bodies[j].x, bodies[j].y);
      if(bodies[i].m>0) {
        dvxdt[i] += G*(bodies[j].m*(bodies[i].x-bodies[j].x)/pow(r, 3));
        dvydt[i] += G*(bodies[j].m*(bodies[i].y-bodies[j].y)/pow(r, 3)); 
      }
      else {
        dvxdt[i] -= G*(bodies[j].m*(bodies[i].x-bodies[j].x)/pow(r, 3));
        dvydt[i] -= G*(bodies[j].m*(bodies[i].y-bodies[j].y)/pow(r, 3)); 
      }
    }
  }

  for (int i=0; i<numObj; i++) {
    bodies[i].vx += dvxdt[i];
    bodies[i].vy += dvydt[i];
    bodies[i].x += bodies[i].vx;
    bodies[i].y += bodies[i].vy;
  }
}

void drawGravFunctions() {
  noStroke();
  colorMode(RGB);
  fill(color(0, 0, 0));
  pushMatrix();
  translate(0, 100);
  rect(width-330, 30, 300, 100);

  stroke(color(255, 255, 255));
  strokeWeight(2);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 150<mouseY && mouseY<170)
    fill(color(40, 40, 40));
  if (neg_charge)
    fill(color(255, 255, 255));
  rect(width-310, 50, 20, 20);

  fill(color(0, 0, 0, 70));
  if (width-310<mouseX && mouseX<width-290 && 190<mouseY && mouseY<210)
    fill(color(40, 40, 40));
  if (start)
    fill(color(255, 255, 255));
  rect(width-310, 90, 20, 20);


  fill(color(255, 255, 255));
  textSize(18);
  text("- Charge", width-275, 67);
  text("Start Animation", width-275, 107);
  popMatrix();

  colorMode(RGB);
  fill(color(0, 0, 0));
  if (width-230< mouseX && mouseX < width-30 && 30 < mouseY && mouseY < 130) {
    fill(color(60, 60, 60));
    if (mousePressed && mode == 2) {
      mode = 0;
      numObj = 0;
      oddity = 0;
      bodyFirstTime = true;
      for (int i=0; i<numObj; i++) {
        bodies[i] = null;
        dvxdt[i] = 0;
        dvydt[i] = 0;
      }
    }
  }
  stroke(color(255, 255, 255));
  rect(width-230, 30, 200, 70);
  fill(color(255, 255, 255));
  textSize(25);
  textAlign(CENTER, CENTER);
  text("Go back", width-130, 60);
  textAlign(CORNER, CORNER);
}


/*
void drawGravCoordinate() {
  colorMode(RGB);
  background(color(0, 0, 0));
  for (int i=1; i<=4; i++) {
    stroke(color(50, 50, 50));
    strokeWeight(1);
    line(width/2+i*xgap, 0, width/2+i*xgap, height);
    line(width/2-i*xgap, 0, width/2-i*xgap, height);
  }
  for (int i=1; i<=3; i++) {
    line(0, height/2+i*ygap, width, height/2+i*ygap);
    line(0, height/2-i*ygap, width, height/2-i*ygap);
  }
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
}*/

void plotGravODE() {
  for (int j=-17; j<=17; j++) {
    for (int k=-15; k<=15; k++) {
      float curX = width/2+j*60;
      float curY = height/2+k*40;

      float vecX = 0, vecY = 0;

      for (int q=0; q<numObj; q++) {
        float r = dist(curX, curY, bodies[q].x, bodies[q].y);
        vecX += (bodies[q].m*(curX-bodies[q].x)/pow(r, 3));
        vecY += (bodies[q].m*(curY-bodies[q].y)/pow(r, 3));
      }


      float size = sqrt(vecX*vecX+vecY*vecY);

      colorMode(HSB, 100);
      stroke(map(size*100, 0, 1, 50, 0), 100, 100);
      strokeWeight(2);
      fill(map(size*100, 0, 1, 50, 0), 100, 100);

      drawArrow(curX, curY, curX+vecX/size*20, curY+vecY/size*20, 0, 5, true);
      
    }
  }
  colorMode(RGB);
}
