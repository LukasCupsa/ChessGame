  //BISHOP CODE
class Bishop extends Pieces { // extend from Pieces superclass to allow all the pieces to be in the same hashmap
  int x;
  int y;
  String colour;
  boolean isAlive = true;
   public Bishop(int x, int y, String colour) {
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
    
    int changeInX = moveX/100-this.x/100;
    int changeInY = this.y/100-moveY/100;
    int minX = Math.min(this.x/100, moveX/100)-1;
    int maxX = Math.max(this.x/100, moveX/100)-1;
    int maxY = Math.max(this.y/100, moveY/100)-1;
    if(Math.abs(changeInX)==Math.abs(changeInY) && changeInX!=0 && changeInY!=0) { // if the x and y distance traveled are the same
      if(changeInX>0  && changeInY>0 || changeInX<0 && changeInY<0) { // if the bishop wants to move along the positive diagonal(y = x graph)
      // loop through all the squares in between to make sure the bishop is not getting blocked
           for(int i = 1;i<Math.abs(changeInX);i++) { 
            if(!board[minX+i][maxY-i].piece.equals("")) {
              return false;
        }   
        }
    }
    else {
       // loop through all the squares in between to make sure the bishop is not getting block(if the bishop wants to move along the negative diagonal(y = -x graph)
         for(int i = 1;i<Math.abs(changeInX);i++) {
            if(!board[maxX-i][maxY-i].piece.equals("")) {
              return false;
        }   
        }
      
    }
     if(!board[moveX/100-1][moveY/100-1].piece.equals("")) {
         return capturePossible(moveX, moveY);
      }
    return true;
    
  }
  return false;
  }

   boolean capturePossible(int moveX, int moveY) { // if a capture is possible
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
      image(whiteBishop, this.x, this.y);
    }
    else {
      image(blackBishop, this.x, this.y);
      
    }
    
  }
}
