//a global function to instantiate an object
void Instantiate(GameObject go){
  gamestateManager.gamestates.get(gamestateManager.activeState).objectManager.Instantiate(go);
}
//a global function to destroy an object
void Destroy(GameObject go){
  gamestateManager.gamestates.get(gamestateManager.activeState).objectManager.Destroy(go);
}
