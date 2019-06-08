class body {
  float x, y, m, vx, vy;
  
  body(float _x, float _y, float _m, float _vx, float _vy) {
    x = _x; y = _y; m = _m;
    vx = _vx; vy = _vy;
  }
  void drawBody() {
    noStroke();
    fill(color(255, 255, 255, 80));
    ellipse(x, y, m*2, m*2);
    stroke(color(255, 255, 255));
    strokeWeight(2);
    drawArrow(x, y, x+vx*40, y+vy*40, 0, 5, true);
  }
}
