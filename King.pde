//KING CODE

class King extends Pieces { // extend from Pieces superclass to allow all the pieces to be in the same hashmap
  int x;
  int y;
  String colour;
  boolean isAlive = true;
   public King(int x, int y, String colour) {
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
    if(moveX>=900 || moveX<=99 || moveY>=900 || moveY<=99) { // ensure the "move" is not outside the board
      return false; 
    }
  int changeInX = moveX/100-this.x/100;
  int changeInY = moveY/100-this.y/100;
  if((changeInX==0 || Math.abs(changeInX)==1) &&  (changeInY==0 || Math.abs(changeInY)==1) && (!(changeInX==0 && changeInY==0))) { // if the x coordinate and the y coordinate only have a maximum change of 1 and they are both not zero
    if(!willGetChecked(moveX,  moveY)) { // check if the king will get checked if it moves to the square
      if(!board[moveX/100-1][moveY/100-1].piece.equals("")) {
        return capturePossible( moveX,  moveY); // check if it can capture the piece on the square if there is one
      }      
    }
    else {
      return false;
    }
    return true;
  }
  return false;
  }
  boolean kingCheckPossible(int moveX, int moveY) { // check if the other king can check your king if ur king moves to a square
      int changeInX = moveX/100-this.x/100;
      int changeInY = moveY/100-this.y/100;
      if((changeInX==0 || Math.abs(changeInX)==1) &&  (changeInY==0 || Math.abs(changeInY)==1) && (!(changeInX==0 && changeInY==0))) {
        return true;
  }
  return false;
  }
  boolean willGetChecked(int moveX, int moveY) {
    // temporaily "make the move" to see if the king will get checked
     tempPieceForKing = board[moveX/100-1][moveY/100-1].piece;
     tempKing = board[this.x/100-1][this.y/100-1].piece;
      board[this.x/100-1][this.y/100-1].piece = "";
     if(this.colour.equals("white")) {
       board[moveX/100-1][moveY/100-1].piece = "whiteKing1";
     }
     else {
       board[moveX/100-1][moveY/100-1].piece = "blackKing1";
     }
  for(Pieces value : piecesMap.values()) { // loop through all the pieces to see if any enemy piece will check the king if the king moves
    if(value.getIsAlive()) {
    if(value.getClass()==Pawn.class) { 
      if(value.capturePossible(moveX, moveY)) {
        resetValues(tempKing, tempPieceForKing,this.x, this.y, moveX, moveY);
        checkingPiece = value;
        return true;  
      }
    }
    else if(value.getClass()==King.class && !value.getColour().equals(this.colour)) { 
      if(value.kingCheckPossible(moveX, moveY)) {   
         resetValues(tempKing, tempPieceForKing,this.x, this.y, moveX, moveY);
         checkingPiece = value;
        return true;  
      }
    }
    else if(value.getClass()!=King.class) {
      if(value.movePossible(moveX, moveY)) {
          resetValues(tempKing, tempPieceForKing,this.x, this.y, moveX, moveY);
          checkingPiece = value;
        return true;  
      }  
    }
  }
  }
  
  resetValues(tempKing, tempPieceForKing,this.x, this.y, moveX, moveY);
  return false;  
  }
  
  boolean capturePossible(int moveX, int moveY) { // check if the king can capture the enemy piece
      if(board[moveX/100-1][moveY/100-1].piece.substring(0,5).equals(this.colour)) {
        return false;
      }
      return true;
    }
   void display() {
    if(this.colour.equals("white")) {
      image(whiteKing, this.x, this.y);
    }
    else {
      image(blackKing, this.x, this.y);
      
    }
    
   }
}
