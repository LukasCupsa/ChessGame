//KNIGHT CODE

class Knight extends Pieces { // extend from Pieces superclass to allow all the pieces to be in the same hashmap
  int x; 
  int y;
  String colour;
  boolean isAlive = true;
   public Knight(int x, int y, String colour) {
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
    int changeInX = Math.abs(moveX/100-this.x/100);
    int changeInY = Math.abs(moveY/100-this.y/100);
    if((changeInX==2 && changeInY==1) || (changeInX==1 && changeInY==2)) { // check if the change in x is 2 and the change in y is 1 or vice versa(to create the L shape)
        if(!board[moveX/100-1][moveY/100-1].piece.equals("")) { // if there is a piece where the knight wants to move to, check if it can capture the piece
         return capturePossible(moveX, moveY);
      }
      return true;
      
    }
    return false;

  }
     boolean capturePossible(int moveX, int moveY) { // check if the knight can capture the piece
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
      image(whiteKnight, this.x, this.y);
    }
    else {
      image(blackKnight, this.x, this.y);
      
    }
    
  }
}
