//setup global objects
public Time time;
public GamestateManager gamestateManager;
public Input input;
public Camera camera; 

//setup base settings for program
void settings() {
  size(700, 500);
}

//setup other settings and initialize global objects
void setup() {
    frameRate(120);
  //global objects
  time = new Time();
  gamestateManager = new GamestateManager();
  input = new Input();
  camera = new Camera();
  //add scenes to game
  gamestateManager.addState(new main());
}

//global update function (called every frame)
void draw() {
  background(155);
  //update all global classes
  camera.Update();
  input.Update();
  time.Update();
  gamestateManager.Update();
  
  //used to modify game speed with UI
  //set timespeed to normal speed
  time.gameSpeed = 3;
  //if timeslow is active slow own the gamespeed
  if (this.timeslow) {
    time.gameSpeed = 1;
  }
  this.timeslow = false;
  //if time speed up is active speed up gamespeed
  if (this.timespeed) {
    time.gameSpeed = 5;
  }
  this.timespeed = false;
}

//variables to modify gamespeed
boolean timeslow = false;
boolean timespeed= false;

void timeSlow() {
  timeslow = true;
}
void timeSpeed() {
  timespeed= true;
}
