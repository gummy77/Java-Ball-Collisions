//class to manage the positioning of the camera
class Camera{
  //initialize variables
  public Transform2d transform;
  
  //class init funciton
  public Camera(){
    this.transform = new Transform2d();
  }
  
  //update function
  public void Update(){
    translate(width/2, height/2);
    translate(-this.transform.position.x, -this.transform.position.y);
    rotate(this.transform.rotation);
  }
}
