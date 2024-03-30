//class to manage all gamestates an update the active one.
class GamestateManager {
  ArrayList<Gamestate> gamestates;
  public int activeState = 0;

  //initialize gamobject list
  GamestateManager() {
    this.gamestates = new ArrayList<Gamestate>();
  }

  //adds a gamestate to the list, and runs the start function on it.
  void addState(Gamestate gs) {
    this.gamestates.add(gs);
    this.activeState = this.gamestates.size()-1;
    gs.Start();
  }

  //Updates the current state
  void Update() {
    Gamestate curState = this.gamestates.get(activeState);
    curState.Update();
  }
}




//class for current game states
class Gamestate {
  ObjectManager objectManager;
  UIManager uiManager;

  //initialize
  Gamestate() {
    this.objectManager = new ObjectManager(this);
    this.uiManager = new UIManager(this);
  }

  //funciton run at the start of the game
  void Start(){
    
  }

  //function run every frame when this scene is active
  void Update() {
    //run all the functions for the objects in the scene.
    this.objectManager.Update();
    this.uiManager.Update();
    this.objectManager.Show();
    this.uiManager.Show();
    this.objectManager.LateUpdate();
  }
}
