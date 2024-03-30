//class to manage inputs
class Input {

  //initialise all the variables
  public boolean overUI;

  //for the mouse inputs
  private boolean mouseIsLeft = false;
  private boolean mouseIsRight = false;
  private boolean mouseIsMiddle = false;

  //for the keyboard keys (an array so i dont need a billion individual variables)
  private boolean[] keys;


  //Initialise class function
  Input() {
    this.keys = new boolean[keynum.len];
  }

  //update run every frame
  public void Update() {
  }

  //public method to get mouse Input when the mouse is NOT over UI (for anything but ui)
  public boolean getButtonDown(int n) {
    if (!this.overUI) {
      switch(n) {
        case(RIGHT):
        return this.mouseIsRight;
        case(LEFT):
        return this.mouseIsLeft;
        case(CENTER):
        return this.mouseIsMiddle;
      default:
        return false;
      }
    } else {
      return false;
    }
  }

  //public function for other scripts to get keyboard input
  public boolean getKeyDown(int n) {
    if (this.keys[n]) {
      return true;
    } else {
      return false;
    }
  }

  //public functin for other scripts to get mouse input when the mouse is over UI (for UI)
  public boolean getButtonDownUI(int n) {
    if (this.overUI) {
      switch(n) {
        case(RIGHT):
        return this.mouseIsRight;
        case(LEFT):
        return this.mouseIsLeft;
        case(CENTER):
        return this.mouseIsMiddle;
      default:
        return false;
      }
    } else {
      return false;
    }
  }

  //method to set the variables
  public void mousePress(int m, boolean b) {
    switch(m) {
      case(LEFT):
      this.mouseIsLeft = b;
      case(RIGHT):
      this.mouseIsRight = b;
      case(CENTER):
      this.mouseIsMiddle = b;
    }
  }
  
  //function to set the variables when a key is pressed
  public void keyPress(int m, boolean b) {
    if (m < keynum.len) {
      this.keys[m] = b;
    }
  }
}

//global list of key codes
interface keynum {
  int
    a = 0, 
    b = 1, 
    c = 2, 
    d = 3, 
    e = 4, 
    f = 5, 
    g = 6, 
    h = 7, 
    i = 8, 
    j = 9, 
    k = 10, 
    l = 11, 
    m = 12, 
    n = 13, 
    o = 14, 
    p = 15, 
    q = 16, 
    r = 17, 
    s = 18, 
    t = 19, 
    u = 20, 
    v = 21, 
    w = 22, 
    x = 24, 
    y = 25, 
    z = 26;
  int
    len = 26;
}

//functions that run when keys are pressed
void mousePressed() {
  input.mousePress(mouseButton, true);
}
void mouseReleased() {
  input.mousePress(mouseButton, false);
}
void keyPressed() {
  input.keyPress(keyToCode(key), true);
}
void keyReleased() {
  input.keyPress(keyToCode(key), false);
}

//bad ignore pls dont look noooooo
int keyToCode(char c) {
  switch(c) {
  case 'a':
    return 0;
  case 'b':
    return 1;
  case 'c':
    return 2;
  case 'd':
    return 3;
  case 'e':
    return 4;
  case 'f':
    return 5;
  case 'g':
    return 6;
  case 'h':
    return 7;
  case 'i':
    return 8;
  case 'j':
    return 9;
  case 'k':
    return 10;
  case 'l':
    return 11;
  case 'm':
    return 12;
  case 'n':
    return 13;
  case 'o':
    return 14;
  case 'p':
    return 15;
  case 'q':
    return 16;
  case 'r':
    return 17;
  case 's':
    return 18;
  case 't':
    return 19;
  case 'u':
    return 20;
  case 'v':
    return 21;
  case 'w':
    return 22;
  case 'x':
    return 23;
  case 'y':
    return 24;
  case 'z':
    return 25;
  default:
    return keynum.len;
  }
}
