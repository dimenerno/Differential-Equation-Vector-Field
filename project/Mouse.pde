
int oddity = 0;
void mousePressed() {
  // Pendulum
  if (mode == 1) {
    if (sliderXpos-5<mouseX && mouseX<sliderXpos+5 && height-135 < mouseY && mouseY < height-105 ) {
      locked = true;
      sliderXpos = mouseX;
    }
  }
}


void mouseDragged() {
  // Pendulum
  if (mode == 1) {
    if (width-330 < mouseX && mouseX < width-70 && locked) {
      sliderXpos = mouseX;
      mu = map(mouseX - (width-200), -130, 130, 1, -1);
      background(0);
      drawCoordinate();
      plotODE();
    }
  }
}

void mouseReleased() {
  if (mode == 1) {
    locked = false;
    if (width-310<mouseX && mouseX<width-290 && 150<mouseY && mouseY<170) {
      if (scale) scale = false;
      else scale = true;
      return;
    }
    if (width-310<mouseX && mouseX<width-290 && 190<mouseY && mouseY<210) {
      if (showD) showD = false;
      else showD = true;
      return;
    }
    if (width-310<mouseX && mouseX<width-290 && 230<mouseY && mouseY<250) {
      if (showPendulum) showPendulum = false;
      else showPendulum = true;
      return;
    }  
    if (width-310<mouseX && mouseX<width-290 && 270<mouseY && mouseY<290) {
      if (showProj) showProj = false;
      else showProj = true;
      return;
    }  
    if (width-310<mouseX && mouseX<width-290 && 310<mouseY && mouseY<330) {
      if (erased) 
        erased = false;
      else {
        erased = true;
        objOn = false;
      }
      return;
    }
    if (width-310<mouseX && mouseX<width-290 && 350<mouseY && mouseY<370) {
      if (gameOn) gameOn = false;
      else gameOn = true;
      return;
    }  


    if (!(sliderXpos-5<mouseX && mouseX<sliderXpos+5 && height-135 < mouseY && mouseY < height-105)) {
      if (first_time) first_time = false;
      else {
        objOn = true;
        newObj = true;
        first_time = false;
        obj = new Pendulum(xtoTheta(mouseX), ytoThetadot(mouseY));
      }
    }
  }

  if (mode == 2) {

    if (width-310<mouseX && mouseX<width-290 && 150<mouseY && mouseY<170) {
      if (neg_charge) neg_charge = false;
      else neg_charge = true;
      return;
    }
    if (width-310<mouseX && mouseX<width-290 && 190<mouseY && mouseY<210) {
      if (start) start = false;
      else start = true;
      return;
    }
    if (width-310<mouseX && mouseX<width-290 && 230<mouseY && mouseY<250) {
      if (showPendulum) showPendulum = false;
      else showPendulum = true;
      return;
    }
    if (!bodyFirstTime && oddity%3 == 1) {
      bodies[numObj] = new body(mouseX, mouseY, 0, 0, 0);
      numObj += 1;
    }
    if (!bodyFirstTime && oddity%3 == 2) {
      bodies[numObj-1].vx = (mouseX - bodies[numObj-1].x)/40;
      bodies[numObj-1].vy = (mouseY - bodies[numObj-1].y)/40;
    }
    if (!bodyFirstTime && oddity%3 == 0) {
      if(neg_charge) bodies[numObj-1].m = -dist(mouseX, mouseY, bodies[numObj-1].x, bodies[numObj-1].y);
      else bodies[numObj-1].m = dist(mouseX, mouseY, bodies[numObj-1].x, bodies[numObj-1].y);
    }
    bodyFirstTime = false;
    oddity += 1;
  }
}
