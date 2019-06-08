class Animation {
  void animate() {
    pushMatrix();
    translate(80, 80);
    ellipse(L*cos(theta), L*sin(theta), 20, 20);
    popMatrix();
  }
}
