//class for the collider pat of a gameobject
class Collider {
  //initilise varaibles
  public GameObject gameobject;

  //variables for a sphere collider
  boolean isSphere;
  float radius;

  //variables for a polygonal collider
  boolean hasLines;
  vector2d[] lines;

  //initialize class when it has no colliders yet
  Collider(GameObject parent) {
    this.gameobject = parent;
    this.isSphere = false;
    this.hasLines = false;
  }

  //initialise class when it has lines
  Collider(GameObject parent, vector2d[] _lines) {
    this.gameobject = parent;
    this.isSphere = false;
    this.hasLines = true;
    this.lines = _lines;
  }

  //initialize classs when it has sphere
  Collider(GameObject parent, float _radius) {
    this.gameobject = parent;
    this.isSphere = true;
    this.hasLines = false;
    this.radius = _radius;
  }

  //function for checking if there are any collisions with any spheres
  GameObject checkSphereCollisions(ArrayList<GameObject> gameObjects) {
    //loop over all objects
    for (int i = 0; i < gameObjects.size(); i++) {
      GameObject curObject = gameObjects.get(i);
      //make sure not including itself
      if(curObject==gameobject)continue;
      //make sure the object has a collider
      if (curObject.collider != null) {
        //make sure the object has a sphere collider
        if (curObject.collider.isSphere) {
          //check if the two spheres are colliding
          if(this.isSphereColliding(curObject.transform.position, curObject.collider.radius, this.gameobject.transform.position, this.radius)){
            return curObject;
          }
        }
      }
    }
    return null;
  }

  //function for checking if there are any collisions with any lines
  vector2d[] checkLineCollisions(ArrayList<GameObject> gameObjects) {
    //loop over all objects
    for (int i = 0; i < gameObjects.size(); i++) {
      GameObject curObject = gameObjects.get(i);
      //make sure not including self
      if(curObject==gameobject)continue;
      //make sure the object has a collider
      if (curObject.collider != null) {
        //make sure the object has a sphere collider
        if (curObject.collider.hasLines) {
          //loop over every line in object
          for (int j = 0; j < curObject.collider.lines.length; j+=2) {
            //check if actually colliding
            vector2d[] col = this.isLineColliding(curObject.collider.lines[j], curObject.collider.lines[j+1], this.gameobject.transform.position, this.radius);
            if (col != null) {
              return col;
            }
          }
        }
      }
    }
    return null;
  }

  //check if two spheres are colliding
  private boolean isSphereColliding(vector2d op, float or, vector2d tp, float tr) {
    if (op.dist(tp)-(or+tr) <= 0) {
      return true;
    }
    return false;
  }

  //check if sphere is colliding with line
  private vector2d[] isLineColliding(vector2d p1, vector2d p2, vector2d c, float r) {
    //p1 is the first line point
    //p2 is the second line point
    //c is the circle's center
    //r is the circle's radius

    vector2d p3 = new vector2d(p1.x - c.x, p1.y - c.y); //shifted line points
    vector2d p4 = new vector2d(p2.x - c.x, p2.y - c.y);

    float m = (p4.y - p3.y) / (p4.x - p3.x); //slope of the line
    float b = p3.y - m * p3.x; //y-intercept of line

    double underRadical = (r*r)*(m*m) + (r*r) - (b*b); //the value under the square root sign 


    if (underRadical < 0) {
      //line completely missed
      return null;
    } else {
      vector2d nearestPoint;
      //get closest point
      vector2d A = p1.clone();
      vector2d B = p2.clone();
      vector2d P = c.clone();

      vector2d AP = new vector2d(P.x - A.x, P.y - A.y);       //Vector from A to P   
      vector2d AB = new vector2d(B.x - A.x, B.y - A.y);       //Vector from A to B  
      float magnitudeAB = AB.mag()*AB.mag();//AB.x*AB.x + AB.y*AB.y;     //Magnitude of AB vector (it's length squared)     
      float ABAPproduct = dot(AB, AP);//((AB.x * AP.x) + (AB.y * AP.y));    //The DOT product of a_to_p and a_to_b     
      float distance = ABAPproduct / magnitudeAB; //The normalized "distance" from a to your closest point  

      nearestPoint = A.add(AB.mult(distance));
      if (distance > 1 || distance < 0) {
        return null;
      } else {
        double t1 = (-m*b + Math.sqrt(underRadical))/(Math.pow(m, 2) + 1); //one of the intercept x's
        double t2 = (-m*b - Math.sqrt(underRadical))/(Math.pow(m, 2) + 1); //other intercept's x

        vector2d i1 = new vector2d((float)(t1+c.x), (float)(m*t1+b+c.y)); //intercept point 1
        vector2d i2 = new vector2d((float)(t2+c.x), (float)(m*t2+b+c.y)); //intercept point 2
        vector2d a = p3.vectorTo(p4);
        vector2d normal = new vector2d(a.y, a.x*-1).normalize();

        return new vector2d[] {i1, i2, normal, nearestPoint};
      }
    }
  }
}
