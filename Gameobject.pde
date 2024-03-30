//class to manager gameobjects and run all their regular funtions
class ObjectManager {
  public ArrayList<GameObject> gameObjects;
  public Gamestate state; 

  //create function
  ObjectManager(Gamestate _state) {
    this.gameObjects = new ArrayList<GameObject>();
    this.state = _state;
  }

  //funciton that adds a gameobject to the list and makes sure to run all the funcitons
  void Instantiate(GameObject go) {
    this.gameObjects.add(go);
    go.state = this.state;
    go.manager = this;
    go.Start();
  }

  //"detroys" an objects by removing it from the list and stopping it from updating
  //I'll probably need to learn to properly destroy objects or I'll have a memory issue
  void Destroy(GameObject go) {
    this.gameObjects.remove(go);
  }

  //runs all the objects update function
  void Update() {
    for (int i =0; i < gameObjects.size(); i++) {
      GameObject curObj = this.gameObjects.get(i);

      curObj.trueUpdate();
    }
  }

  //runs all the objects show function
  void Show() {
    for (int i =0; i < gameObjects.size(); i++) {
      GameObject curObj = this.gameObjects.get(i);

      curObj.Show();
    }
  }

  //runs all the objects lateupdate function;
  void LateUpdate() {
    for (int i =0; i < gameObjects.size(); i++) {
      GameObject curObj = this.gameObjects.get(i);

      curObj.trueLateUpdate();
    }
  }
}



//base class for a gameobject
class GameObject {
  public Transform2d transform;
  public Collider collider;
  public Rigidbody2d rigidbody;
  public Gamestate state;
  public ObjectManager manager;

  //creation function
  GameObject() {
    //initialize variables
    this.transform = new Transform2d();
    this.rigidbody = new Rigidbody2d(this);
  }

  void trueUpdate() {
    if (this.collider != null) {
    }
    this.rigidbody.Update();
    this.Update();
  }
  void trueLateUpdate(){
    this.rigidbody.LateUpdate();
    this.LateUpdate();
  }

  //function run at load of scene
  void Start() {
    this.collider = null;
  }

  //base update class (will be used in extends)
  void Update() {
  }
  //base late update class (happens after everything else)
  void LateUpdate() {
  }
  //base show class (will be used for rendering the objects)
  void Show() {
  }
}
