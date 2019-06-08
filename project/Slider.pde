class Slider {
  // SLIDER 

  float slider_width = 50;
  float slider_height = 10;
  float posx, posy;
  boolean over = false;
  boolean locked = false;
  float xoff;
  float fundo;

  void drawslider() {
    pushMatrix();
    //translate(width/2, height/2);
    posx = width/2;
    posy = height/2;
    rectMode(CENTER);
    line (posx, posy, posx+100, posy);
    fundo = posx;
    line (150, posy, 350, posy);
    if (dist(mouseX, mouseY, posx, posy) < slider_height) {
      fill(200);
      over = true;
    } else {
      fill(255);
      over = false;
    }


    if (posx < 175) {
      posx = 175;
    }

    if (posx > 325) {
      posx = 325;
    }


    rect(posx, posy, slider_width, slider_height);
    popMatrix();
  }



  void mousePressed() {
    if (over) {
      locked = true;
      xoff = mouseX-posx;
    }
  }
  void mouseDragged() {
    if (locked) {
      posx = mouseX-xoff;
    }
  }
  void mouseReleased() {
    locked = false;
  }
}
