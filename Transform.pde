//class for transform
class Transform2d {
  public vector2d position;
  public float rotation;

  //initialise class
  Transform2d(float _posX, float _posY, float _rotation) {
    this.position = new vector2d(_posX, _posY);
    this.rotation = _rotation;
  }
  Transform2d(float _posX, float _posY) {
    this.position = new vector2d(_posX, _posY);
    this.rotation = 0;
  }
  Transform2d() {
    this.position = new vector2d();
    this.rotation = 0;
  }
  //functions to move position
  void move(vector2d d) {
    this.position.add(d);
  }
  void move(float _x, float _y) {
    this.position.add(new vector2d(_x, _y));
  }
}
