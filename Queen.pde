//QUEEN CODE

class Queen extends Pieces { // extend from Pieces superclass to allow all the pieces to be in the same hashmap
  int x;
  int y;
  String colour;
  boolean isAlive = true;
   public Queen(int x, int y, String colour) {
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
  boolean movePossible(int moveX, int moveY) {
    Bishop tempBishop = new Bishop(this.x, this.y, this.colour); // create a temporary rook in the queens position
    Rook tempRook = new Rook(this.x, this.y, this.colour); // create a temporary bishop in the queens position
    if(tempBishop.movePossible(moveX, moveY) || tempRook.movePossible(moveX, moveY)) { // if the rook or bishop can move to the square than the queen can as well
        
      return true;
    }
    return false;
  }
   boolean capturePossible(int moveX, int moveY) { // check if it can capture the piece on the square
      if(board[moveX/100-1][moveY/100-1].piece.substring(0,5).equals(this.colour)) {
        return false;
      }
      return true;
    }
void killPiece() {
    this.isAlive = false;
  }
   void display() {
    if(this.colour.equals("white")) {
      image(whiteQueen, this.x, this.y);
    }
    else {
      image(blackQueen, this.x, this.y);
      
    }
    
  }
}
