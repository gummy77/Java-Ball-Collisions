//gamestate for this current program
class main extends Gamestate {
  //init variables
  float groundRes = 100;
  float seed;

  //function run at load
  void Start() {
    //sets the seet for the ground objects
    this.seed = random(999999);

    //spawn all the ground segment objects
    Instantiate(new debugSceneFather());
    for (int i = -width/2; i < width/2; i+=groundRes) {
      Instantiate(new groundSegment(i, this.groundRes, this.seed));
    }
  }
}
//class for the scene to manage the world
class debugSceneFather extends GameObject {
  //init variables
  public Text dInfo;

  //start function run at game start
  void Start() {
    //create text gameobjects
    dInfo = new Text("");
    Button slowButton = new Button("timeSlow", "Slow Time", color(100, 100, 100), width/2-125, -height/2+5, 120, 30);
    Button speedButton = new Button("timeSpeed", "Speed Time", color(100, 100, 100), width/2-125, -height/2+40, 120, 30);

    //append them to the UI manager
    this.state.uiManager.AddUI(dInfo);
    this.state.uiManager.AddUI(slowButton);
    this.state.uiManager.AddUI(speedButton);
    //put the text into position
    dInfo.transform.position = new vector2d(-width/2+20, -height/2+20);

    //create and add the colliders to the edges of the screen
    vector2d[] points = {new vector2d(-width/2, height/2), new vector2d(width/2, height/2), new vector2d(-width/2, -height/2), new vector2d(-width/2+0.001, height/2), new vector2d(width/2, height/2), new vector2d(width/2+0.001, -height/2), new vector2d(width/2, -height/2), new vector2d(-width/2, -height/2)};
    this.collider = new Collider(this, points);
  }

  //update function run every frame
  void Update() {
    //spawn a new sphere when mosue is pressed
    if (input.getButtonDown(LEFT)) {
      Instantiate(new sphere((mouseX-width/2)+random(-10.00, 10.00), (mouseY-height/2)+random(-10.00, 10.00), random(10, 20)));
    }
    //set the unfo text to accurate numbers
    dInfo.text = "Real Time: "+time.realTime+"\nGame Time: "+time.gameTime+"\nDelta Time: "+time.deltaTime+"\nFPS: "+time.fps+"\nObject count: "+this.state.objectManager.gameObjects.size();
  }
}

//class for the ground segments
class groundSegment extends GameObject {
  //init variables
  float lineSpread;
  float seed;

  //init function
  groundSegment(float _posx, float _groundRes, float _seed) {
    //set variables
    this.transform.position = new vector2d(_posx, height/2-10);
    this.lineSpread = _groundRes;
    this.seed = _seed;
  }

  //function run at object start
  void Start() {
    //local variables for the math to be readable
    float thix = this.transform.position.x;
    float thiy = this.transform.position.y;

    //mmath to set collider points
    vector2d[] points = {new vector2d(thix, thiy-(this.getHeight(thix))), new vector2d(thix+this.lineSpread, thiy-(this.getHeight(thix+this.lineSpread)))};
    this.collider = new Collider(this, points);
  }

  //function used to draw the line
  void Show() {
    //variables used to shorten the math
    float thix = this.transform.position.x;
    float thiy = this.transform.position.y;

    //draw the line in the correct colour and function
    strokeWeight(2);
    stroke(0);
    line(thix, thiy-(this.getHeight(thix)), thix+this.lineSpread, thiy-(this.getHeight(thix+this.lineSpread)));
  }

  //funciton to easily edit the noise values
  float getHeight(float x) {
    return noise((x*0.008)+this.seed)*150;
  }
}

//sphere class
class sphere extends GameObject {
  //init variables
  color colour;
  float girth;
  float lifetime = 0;
  float maxLife;

  //init function
  sphere(float x, float y, float _g) {
    //set variables
    this.colour = color(random(255), random(255), random(255));
    this.girth = _g;
    this.rigidbody = new Rigidbody2d(this, /*density*/ 2*(PI*(this.girth*this.girth)));
    this.transform.position = new vector2d(x, y);
    this.maxLife = random(10, 35);
  }

  //function that runs when object loads
  void Start() {
    //set collider
    this.collider = new Collider(this, this.girth);
  }

  //update function that runs every frame
  void Update() {

    //checks if the spheres has existed for long enough
    if (this.lifetime >= this.maxLife) {
      //destroys the sphere if true
      Destroy(this);
    }

    //'ages' the sphere
    this.lifetime += time.deltaTime;
  }

  //function run everyframe after all the other updates and shows
  void LateUpdate() {
    this.rigidbody.velocity.add(0, 1*9.8*time.deltaTime);
  }

  //function to draw the sphere to the screen
  void Show() {
    fill(this.colour); 
    noStroke(); 
    ellipse(this.transform.position.x, this.transform.position.y, this.girth*2, this.girth*2);
  }
}
