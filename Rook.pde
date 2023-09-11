//ROOK CODE

class Rook extends Pieces { // extend from Pieces superclass to allow all the pieces to be in the same hashmap
  int x;
  int y;
  String colour;
  boolean isAlive = true;
    public Rook(int x, int y, String colour) {
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
       if(moveX/100==this.x/100 && moveY/100!=this.y/100) { // if the rook wants to move on the same x file but to a different square on the y file
           int min = Math.min(moveY, this.y)/100-1;
          for(int i = 1;i<Math.abs((moveY/100-this.y/100));i++) { // loop through all the squares in between the square the rook wants to move to and the square it is in to ensure that there is no piece blocking it
            if(!board[this.x/100-1][min+i].piece.equals("")) {
              return false;
            }
      }
      if(!board[moveX/100-1][moveY/100-1].piece.equals("")) { // if there is a piece on the square that the rook wants to move to see if it can capture it
         return capturePossible(moveX, moveY);
      }
      return true;
     }
  
       else if(moveY/100==this.y/100 && moveX/100!=this.x/100) {  // if the rook wants to move on the same f file but to a different square on the x file
         int min = Math.min(moveX, this.x)/100-1;
          for(int i = 1;i<Math.abs((moveX/100-this.x/100));i++) { // loop through all the squares in between the square the rook wants to move to and the square it is in to ensure that there is no piece blocking it
            if(!board[min+i][this.y/100-1].piece.equals("")) {
              return false;
            }
       }
  
         if(!board[moveX/100-1][moveY/100-1].piece.equals("")) { // if there is a piece on the square that the rook wants to move to see if it can capture it
         return capturePossible(moveX, moveY);
      }
      return true;
     }  
      
       return false;
    }
    
    boolean capturePossible(int moveX, int moveY) { // see if it can capture the piece on the square
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
      image(whiteRook, this.x, this.y);
    }
    else {
      image(blackRook, this.x, this.y);
      
    }
    
  }
}
