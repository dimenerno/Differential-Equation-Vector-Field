class Laser {
  float xpos, ypos;
  Laser(float _xpos, float _ypos) {
    xpos = _xpos;
    ypos = _ypos;
  }
  void shoot() {
    stroke(color(255, 255, 0));
    line(xpos, ypos, xpos, ypos-20);
    noStroke();
  }
}
