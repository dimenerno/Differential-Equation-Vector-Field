class AnimalPhase {
  float rabbit, wolf;
  AnimalPhase(float _rabbit, float _wolf) {
    rabbit = _rabbit;
    wolf = _wolf;
  }

  void plot() {
    colorMode(RGB);
    fill(color(255, 255, 255));
    noStroke();
    ellipse(100+rabbit*a_xgap, 1000-wolf*a_ygap, 4, 4);
  }
}
