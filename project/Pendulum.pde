class Pendulum {
  float theta, theta_dot;
  
  Pendulum(float _theta, float _theta_dot) {
    theta =_theta;
    theta_dot = _theta_dot;
  }
  
  void plot() {
    colorMode(RGB);
    fill(color(255, 255, 255));
    noStroke();
    ellipse(width/2+theta/(PI/2)*xgap, height/2-theta_dot/2*ygap, 7, 7);
  }
}
