//PAWN CODE

//TO DO: Create an if statement for when a pawn reaches the end, it can act like a queen + replace image to queen

class Pawn extends Pieces { // extend from Pieces superclass to allow all the pieces to be in the same hashmap
  int x;
  int y;
  String colour;
  boolean isAlive = true;
  public Pawn(int x, int y, String colour) {
    this.x = x;
    this.y = y;
    this.colour = colour;
  }
  // create accessor methods to access fields from the hashmap 
    Integer getX() {
    return this.x;
  }
   Integer getY() {
    return this.y;
  }
   boolean getIsAlive() {
    return this.isAlive;
  }
   String getColour() {
    return this.colour;
  }
    void makeAlive() {
    this.isAlive = true;
    
  }
  
    void move(int moveX, int moveY) {
      if(this.movePossible(moveX, moveY) && !capturingKing(moveX, moveY)) { // if a capture is possible, 
         if(!board[moveX/100-1][moveY/100-1].piece.equals("")) { 
         if(this.capturePossible(moveX, moveY)) {
           capturePiece(board[moveX/100-1][moveY/100-1].piece);       
         }
         }
       this.x -=((this.x/100)-(moveX/100))*100;
       this.y -= ((this.y/100)-(moveY/100))*100;
         board[moveX/100-1][moveY/100-1].piece = tempPiece; // the newly occupied square's piece field is changed to the piece that is now occupying it
         board[tempSquareX][tempSquareY].piece = ""; // the square of the current position of piece has its piece field changed to "" since the piece is moving to a different square
         switchTurns();
      }
  }
  @Override
  boolean movePossible(int moveX, int moveY) {
    boolean secondRow = false;
    int changeInY = (this.y)/100-(moveY)/100;
    // check if pawn can move twice(on the second row of each side) and change the changeInY of the black pawn 
    if(colour.equals("black")) {
      changeInY*=-1;
      if(this.y/100==2) {
         secondRow = true;
      }
    }
    else {
      if(this.y/100==7) {
        secondRow = true;
      }   
    }
    if(((moveX/100) - (this.x/100)==0)) { // check if it wants to stay in the same x file
      if(objectBlocking()) { // check if any object is blocking the pawn
        if(changeInY==1) {
          return true;
        }
        else if(changeInY==2 && secondRow) { 
          return true;
        }      
      }
       return false;
      
     
    }
    else {
      return capturePossible(moveX, moveY);
      
    }
  }
  boolean capturePossible(int moveX,int moveY) { // check if it can capture the piece
    int changeInY = (this.y/100)-(moveY/100);
    if(this.colour.equals("white")) {
      changeInY*=-1;     
    }
    if(Math.abs(this.x/100-moveX/100)==1 && changeInY==-1) {
      if(!board[moveX/100-1][moveY/100-1].piece.equals("")) {
       if(!board[moveX/100-1][moveY/100-1].piece.substring(0,5).equals(this.colour)) {
      return true;
      }
      }
    }
      return false;   
  }
  boolean objectBlocking() { // check if any piece is blocking the pawn
    if(this.colour.equals("white")) {
      return board[this.x/100-1][(this.y/100-2)].piece.equals("");
    }
     return board[this.x/100-1][(this.y/100)].piece.equals("");
  }
  void killPiece() {
    this.isAlive = false;
  }
  void display() {
    if(this.colour=="white") {
      image(whitePawn, this.x, this.y);
    }
    else {
      image(blackPawn, this.x, this.y);
      
    }
    
  }
  

}
