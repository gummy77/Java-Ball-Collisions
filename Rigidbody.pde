//class for the physics component of a gameobject
class Rigidbody2d {
  //variables
  public GameObject gameobject;
  public float mass;

  public vector2d velocity;
  public boolean isPhysics;

  //init function for objects with mass
  Rigidbody2d(GameObject parent, float _mass) {
    this.gameobject = parent;
    this.velocity = new vector2d();
    this.mass = _mass;
    this.isPhysics = true;
  }
  //init function for objects without mass (static object)
  Rigidbody2d(GameObject parent) {
    this.gameobject = parent;
    this.velocity = new vector2d();
    this.mass = 1;
    this.isPhysics = false;
  }

  //update function run every frame
  public void Update() {
    //checks if physics is active on this gameobject
    if (this.isPhysics) {
      //checks if is actually colliding with a line
      vector2d[] bottom = this.gameobject.collider.checkLineCollisions(gameobject.manager.gameObjects);
      if (bottom != null) {
        vector2d normal = bottom[2];
        //do vector math to add a force to the physics object that is the normal times the "vertical" component of the current velocity 
        float theta = normal.toAngle() - this.velocity.toAngle();
        float H = new vector2d(-this.velocity.x, -this.velocity.y).mag();
        float thetRad = theta*(PI/180);
        this.AddForce(new vector2d(normal.toAngle()).mult(cos(thetRad)*H*-1.95));

        //move the object so its position is not intersecting the line
        float disttoCol = this.gameobject.collider.radius-bottom[3].dist(this.gameobject.transform.position);
        this.gameobject.transform.move(normal.normalize().mult(disttoCol));
      }

      //checks if it is actually collising with a ball
      GameObject ball = this.gameobject.collider.checkSphereCollisions(this.gameobject.manager.gameObjects);
      if (ball != null) {
        vector2d normal = this.gameobject.transform.position.vectorTo(ball.transform.position).normalize();

        //get all the variables smaller so the math is less crowded
        vector2d v1 = this.velocity.clone();//new vector2d(this.velocity.y, this.velocity.x*-1);
        vector2d v2 = ball.rigidbody.velocity.clone();//new vector2d(ball.rigidbody.velocity.y, ball.rigidbody.velocity.x*-1);
        float m1 = this.mass;
        float m2 = ball.rigidbody.mass;
        vector2d p1 = this.gameobject.transform.position.clone();
        vector2d p2 = ball.transform.position.clone();

        //do some math for this objects new velocity
        //have the vriables as unnamed smaller variables to keep the math easier to read and less cluttered
        float mm1 = (2*m2)/(m1+m2);
        float a1 = dot(v1.clone().remove(v2.clone()), p1.clone().remove(p2.clone()));
        float b1 = ((p1.clone().remove(p2.clone())).mag() * (p1.clone().remove(p2.clone())).mag());
        vector2d c1 = (p1.clone().remove(p2.clone())).mult(mm1*(a1/b1));

        //do some math for the other objects new velocity
        float mm2 = (2*m1)/(m1+m2);
        float a2 = dot(v2.clone().remove(v1.clone()), p2.clone().remove(p1.clone()));
        float b2 = ((p2.clone().remove(p1.clone())).mag() * (p2.clone().remove(p1.clone())).mag());
        vector2d c2 = (p2.clone().remove(p1.clone())).mult(mm2*(a2/b2));

        //apply the new velocitys
        this.velocity = v1.remove(c1).mult(0.995);
        ball.rigidbody.velocity = v2.remove(c2).mult(0.995);

        //move this object out of the way so it is no longer collising with the other ball
        vector2d difference = normal.mult(ball.transform.position.clone().dist(this.gameobject.transform.position)-(ball.collider.radius+this.gameobject.collider.radius));
        this.gameobject.transform.move(difference);
      }
    }
  }

  //funciton run everyframe after all the show and normal updates
  public void LateUpdate() {
    if (this.isPhysics) {
      this.gameobject.transform.move(velocity.clone().mult(10*time.deltaTime));
    }
  }

  //public function to add a force to the object
  public void AddForce(vector2d force) {
    this.velocity.add(force);
  }
}
