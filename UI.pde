//class to manage the UI components
class UIManager {
  public ArrayList<UIComponent> UIComponents;
  public Gamestate state;

  //initialise class
  UIManager(Gamestate _state) {
    this.UIComponents = new ArrayList<UIComponent>();
    this.state = _state;
  }

  //adds a UI component to the list
  void AddUI(UIComponent go) {
    this.UIComponents.add(go);
  }

  //update function
  void Update() {
    input.overUI = false;
    for (int i =0; i < UIComponents.size(); i++) {
      UIComponent curUIC = this.UIComponents.get(i);

      curUIC.Update();
    }
  }

  //void to draw all UI to screen
  void Show() {
    for (int i =0; i < UIComponents.size(); i++) {
      UIComponent curUIC = this.UIComponents.get(i);

      curUIC.Show();
    }
  }
}

//UI component base class
class UIComponent {
  public Transform2d transform;

  //initialise class
  public UIComponent() {
    this.transform = new Transform2d();
  }

  //update function to be edited by other subclass
  public void Update() {
  }
  //show function to be edited by other subclass
  public void Show() {
  }
}

//text subclass for text UI
class Text extends UIComponent {
  public String text = "";
  public color textColor;
  public float textSize;

  //init
  public Text(String _text) {
    this.text = _text;
    this.textColor = color(0);
    this.textSize = 20;
  }

  //draw the text
  public void Show() {
    pushStyle();
    fill(this.textColor);
    textSize(this.textSize);
    text(this.text, this.transform.position.x, this.transform.position.y);
    popStyle();
  }
}

//button subclass
class Button extends UIComponent {
  public vector2d size;
  public Text text;
  public color upColour;
  public color downColour;
  public String runFunction;

  private boolean down = false;

  //init
  public Button(String _runFunction, String _text, color _colour, float posx, float posy, float _w, float _h) {
    this.text = new Text(_text);
    this.upColour = _colour;
    this.downColour = color(red(this.upColour)-20, green(this.upColour)-20, blue(this.upColour)-20);
    this.transform.position = new vector2d(posx, posy);
    this.size = new vector2d(_w, _h);
    this.runFunction = _runFunction;
  }

  //update the button to sense if mouse be doing it good
  public void Update() {
    //checks if the mouse is over the button
    if (mouseX-width/2 > this.transform.position.x && mouseX-width/2 < this.transform.position.x+this.size.x && mouseY-height/2 > this.transform.position.y && mouseY-height/2 < this.transform.position.y+this.size.y) {
      input.overUI = true;
      //check is mouse is down
      if (input.getButtonDownUI(LEFT)) {
        this.down = true;
        //run this function
        method(this.runFunction);
      } else {
        this.down = false;
      }
    } else {
      this.down = false;
    }

    this.text.transform.position = this.transform.position.clone().add(5, this.size.y-5);
  }

  //draw the text
  public void Show() {
    pushStyle();
    noStroke();
    //if button is down change colour
    if (down) {
      fill(this.downColour);
    } else {
      fill(this.upColour);
    }
    rect(this.transform.position.x, this.transform.position.y, this.size.x, this.size.y);
    popStyle();
    this.text.Show();
  }
}
