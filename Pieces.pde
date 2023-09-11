//PIECES CLASS CODE
// superclass for each piece class to allow all of them to be in the same hashmap under the Pieces class
class Pieces {
  int x;
  int y;
  String colour;
   boolean isAlive;
  void move(int x, int y) {   
  }
  void display(){
    
  }
  boolean getIsAlive() {
    return this.isAlive;
  }
  void killPiece() {
  }
  boolean movePossible(int x, int y) {
    return false; 
  }
    boolean kingCheckPossible(int x, int y) {
    return false; 
  }
  boolean capturePossible(int x, int y) {
    return false;
    
  }
  void makeAlive() {
    this.isAlive = true;
    
  }
  String getColour() {
    return this.colour;
  }
  Integer getX() {
    return this.x;
  }
   Integer getY() {
    return this.y;
  }
  
}
