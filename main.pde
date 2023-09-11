//MAIN CHESS CODE

// initialize variables

//Placeholder variables
int x = 0;
int y = 0;

//Background image
PImage boardImg;

//Color variable
color colour;

//Multi-dimensional Array for board spaces
Square[][]board = new Square[8][8];


//Value for if piece is "alive" and still in play
boolean isAlive;

//String array for all the pieces
String[] pieces = {"Rook", "Knight", "Bishop", "Queen", "King", "Bishop", "Knight", "Rook"};

//Creation of hashmap for connecting pieces to their position on the map. Using names of pieces (Strings as the key) instead of indices to associate with the pieces themselves (pieces as the value)
HashMap<String, Pieces> piecesMap = new HashMap<String, Pieces>();

//Boolean for if player selects a piece
boolean pieceSelected = false;

//Temporary variables for temporary user selection (player hasn't confirmed choice yet)
String tempPiece;
int tempSquareX;
int tempSquareY;

//Setting a value for each color's turn
String turn = "white";

//Boolean value for second click (to ensure that the player's second click moves the piece)
boolean second;

//Temporary variables for temporary king selection (since you can't put your king in danger) 
String tempPieceForKing;
String tempKing;

//Variables for images for each piece (datatype for storing images)
PImage whiteKing;
PImage blackKing;
PImage whiteQueen;
PImage blackQueen;
PImage whiteBishop;
PImage blackBishop;
PImage whiteKnight;
PImage blackKnight;
PImage whiteRook;
PImage blackRook;
PImage whitePawn;
PImage blackPawn;

//Creating all Pawns using Pawn class (see pawn tab), passing through pixels and color. First number is x coordinate, second is y coordinate (100 spaced for each piece)
Pawn whitePawn1 = new Pawn(125,716, "white");
Pawn whitePawn2 = new Pawn(225,716, "white");
Pawn whitePawn3 = new Pawn(325,716, "white");
Pawn whitePawn4 = new Pawn(425,716, "white");
Pawn whitePawn5 = new Pawn(525,716, "white");
Pawn whitePawn6 = new Pawn(625,716, "white");
Pawn whitePawn7 = new Pawn(725,716, "white");
Pawn whitePawn8 = new Pawn(825,716, "white");
Pawn blackPawn1 = new Pawn(125, 216, "black");
Pawn blackPawn2 = new Pawn(225, 216, "black");
Pawn blackPawn3 = new Pawn(325, 216, "black");
Pawn blackPawn4 = new Pawn(425, 216, "black");
Pawn blackPawn5 = new Pawn(525, 216, "black");
Pawn blackPawn6 = new Pawn(625, 216, "black");
Pawn blackPawn7 = new Pawn(725, 216, "black");
Pawn blackPawn8 = new Pawn(825, 216, "black");

//Creating all Rooks using Rook class (see rook tab), passing through pixels and color
Rook whiteRook1 = new Rook(123, 815, "white");
Rook whiteRook2 = new Rook(823, 815, "white");
Rook blackRook1 = new Rook(123, 115, "black");
Rook blackRook2 = new Rook(823, 115, "black");

////Creating all Bishops using Bishop class (see bishop tab), passing through pixels and color
Bishop whiteBishop1 = new Bishop(317, 815, "white");
Bishop whiteBishop2 = new Bishop(617, 815, "white");
Bishop blackBishop1 = new Bishop(317, 115, "black");
Bishop blackBishop2 = new Bishop(617, 115, "black");

//Creating all Queens using Queen class (see Queen tab), passing through pixels and color
Queen whiteQueen1 = new Queen(412, 814, "white");
Queen blackQueen1 = new Queen(412, 114, "black");

//Creating all Kings using King class (see King tab), passing through pixels and color
King whiteKing1 = new King(514, 814, "white");
King blackKing1 = new King(514, 114, "black");

//Creating all Knights using Knight class (see knight tab), passing through pixels and color
Knight whiteKnight1 = new Knight(217, 817, "white");
Knight whiteKnight2 = new Knight(717, 817, "white");
Knight blackKnight1 = new Knight(217, 117, "black");
Knight blackKnight2 = new Knight(717, 117, "black");

//Initializing variable for piece that is in check
Pieces checkingPiece;

//Initializing variable for King for checking checkmate
King king;

//Boolean for if game is running
boolean gameRunning = true;

//Loading each image into its respective variable
void setup() {
  // load images for pieces and resize them
  boardImg = loadImage("boardImg.jpg");
  whiteKing = loadImage("whiteKing.png");
  blackKing = loadImage("blackKing.png");
  whiteQueen = loadImage("whiteQueen.png");
  blackQueen = loadImage("blackQueen.png");
  whiteBishop = loadImage("whiteBishop.png");
  blackBishop = loadImage("blackBishop.png");
  whiteKnight = loadImage("whiteKnight.png");
  blackKnight = loadImage("blackKnight.png");
  whiteRook = loadImage("whiteRook.png");
  blackRook = loadImage("blackRook.png");
  whitePawn = loadImage("whitePawn.png");
  blackPawn = loadImage("blackPawn.png");
  
  //Resizing each piece to match it's place on the board
  boardImg.resize(1000,1000);
  whitePawn.resize(50,68);
  blackPawn.resize(50,68);
  whiteRook.resize(54,70);
  blackRook.resize(54,70);
  whiteBishop.resize(64,70);
  blackBishop.resize(64, 70);
  whiteQueen.resize(76, 72);
  blackQueen.resize(76, 72);
  whiteKing.resize(72, 72);
  blackKing.resize(72, 72);
  whiteKnight.resize(66,66);
  blackKnight.resize(66,66);
  
  //Used to remove the outline which is used to draw lines and borders around shapes -> removing the border of the board
  noStroke();
  
  //Setting window/board size
  size(1000, 1000);
  
  //loading backround of window to clean grey background
  background(boardImg);
  
  // Method to create a 2d array for the board, assigning color to each square, putting a piece on each square, etc
  initializeBoard();
  
  // Create hashmap to link between String name of piece and Object of piece 
  initializePiecesMap();
}

//Draw function
void draw() {
  
  // Load the background
   background(boardImg);
   
  //Call updateBoard to update board colors (for after check + select)
  updateBoard();
  
  //Call displayAlivePieces to display current pieces that remain (are "alive")
  displayAlivePieces();
  
  // IF statement to display the winner if someone wins
  if(!gameRunning) {
    //Filling text details
     textSize(30);
     
     //Checking who's turn it is that won + Displaying the text above board
     if(turn.equals("white")) {
              fill(#000000);
      text("BLACK WINS!!!!!", 400, 75);
     }
    else {
            fill(#FFFFFF);
      text("WHITE WINS!!!!!", 400, 75);  
    }
  }
}

//Function for when the user clicks
void mousePressed() {
  // only run inside method if game is running
  if(gameRunning){
    
    //Resetting the board colours + pattern
    resetBoardColours();
   
    // get x and y for 3d array depending on the x and y coordinate of the pixels the mouse clicks on (For checking if a piece is clicked on). Dividing by 100 to convert pixel to pieces (separated by 100) and minus 1 to fit our for loop

    x = mouseX/100-1;
    y = mouseY/100-1;
    
    // if piece is selected(clicked on once) and clicked again, move to designated location
    if(pieceSelected==true) {
      
      //Ensuring the mouse is not clicking outside of the board. Pixels greater than 1000 or less than 100 would not register.
      if(x>=0 && x<=7 && y>=0 && y<=7) {
        
        //ensure move does not put your own king in check
        if(!puttingKingInDanger(mouseX, mouseY, tempPiece)) {
         
          // move the piece to the designated square
          movePiece(mouseX, mouseY, tempPiece);
         
         // check if a checkmate has occurred, ending game if yes
         if(checkCheckMate()) {
           gameRunning = false;
       }
    }
    
    //Variable for second click 
    second = true;
    
    //Variable for piece selected 
    pieceSelected = false;
    
    //Variable for piece that is checking
    checkingPiece = null;
  }
    
  }
  
  if(x>=0 && x<=7 && y>=0 && y<=7 && board[x][y].piece!="" && second==false) { // if a piece is clicked on for the first time 
    if(board[x][y].piece.substring(0,5).equals(turn)) {       // ensure piece selected on is the same as whos turn it is
    board[x][y].colour = #D3D3D3;         //Turning the selected square grey
    pieceSelected = true;      //Piece selected becomes true
    tempPiece = board[x][y].piece;      //Temporary piece variable becomes selected piece
    //Coordinates for temp
    tempSquareX = x; 
    tempSquareY = y;
    }
  }
  else {
     pieceSelected = false;  //No piece selected
  }
  second = false;  //No second click
}
}


//Void function to update board
void updateBoard() {
 
  // 8x8 Board
  for(int i = 0;i<8;i++) {
  for(int j = 0;j<8;j++) {
    fill(board[i][j].colour);    //Filling in the color
    rect(i*100+100,j*100+100,100,100);      //Creating rectangle (x, y, w, h)
  }  
}
  
}

//Method to reset the colors of the board in alternating fashion
void resetBoardColours() {
  
  //8x8 Board
  for(int i = 0;i<8;i++) {
   for(int j = 0;j<8;j++) {
     
     //Every other square, color is set
    if((i+j)%2==0) {
       board[i][j].colour = color(250, 236, 235);
    }
    else {
      board[i][j].colour = color(145, 54, 4);
    }
   }
  }  
}


// Void method to initialize board
void initializeBoard() {
  // create 2d array with each square being its own object
  for(int i = 0; i < 8; i ++) {
  for(int j = 0; j < 8 ; j++) {
    if((i+j)%2==0) {
       colour = color(250, 236, 235);
    }
    else {
      colour = color(145, 54, 4);
    }
//initializing the board to have each square’s column, row, and colour be set (see square class code)
    board[i][j] = new Square(char(i+'a'), j+1, colour);
    // assign the "piece" field for the squares that have a piece starting on them
    if(j==1) {
      board[i][j].piece = "blackPawn" + (i+1);
    }
    else if(j==6) {
      board[i][j].piece = "whitePawn" + (i+1);
    }
    else if(j==0) {

      if(i<=4) {
           board[i][j].piece = "black"+pieces[i] + "1";
      }
      else  {
          board[i][j].piece = "black"+pieces[i] + "k2";
        
      }
   
    }
    else if(j==7) {
      if(i<=4) {
           board[i][j].piece = "white"+pieces[i] + "1";
      }
      else  {
           board[i][j].piece = "white"+pieces[i] + "2";
        
      }
    }
  }  
}
}
void initializePiecesMap() {
  // add all the objects into the hashmap. Allows us to retrieve the value of pieces with their given names (the key and value are the same, it’s just for accessibility)
  piecesMap.put("whitePawn1", whitePawn1);
  piecesMap.put("whitePawn2", whitePawn2);
  piecesMap.put("whitePawn3", whitePawn3);
  piecesMap.put("whitePawn4", whitePawn4);
  piecesMap.put("whitePawn5", whitePawn5);
  piecesMap.put("whitePawn6", whitePawn6);
  piecesMap.put("whitePawn7", whitePawn7);
  piecesMap.put("whitePawn8", whitePawn8);
  piecesMap.put("blackPawn1", blackPawn1);
  piecesMap.put("blackPawn1", blackPawn1);
  piecesMap.put("blackPawn2", blackPawn2);
  piecesMap.put("blackPawn3", blackPawn3);
  piecesMap.put("blackPawn4", blackPawn4);
  piecesMap.put("blackPawn5", blackPawn5);
  piecesMap.put("blackPawn6", blackPawn6);
  piecesMap.put("blackPawn7", blackPawn7);
  piecesMap.put("blackPawn8", blackPawn8);
  piecesMap.put("whiteRook1", whiteRook1);
  piecesMap.put("whiteRook1", whiteRook1);
  piecesMap.put("whiteRook2", whiteRook2);
  piecesMap.put("blackRook1", blackRook1);
  piecesMap.put("blackRook2", blackRook2);
  piecesMap.put("whiteBishop1", whiteBishop1);
  piecesMap.put("whiteBishop2", whiteBishop2);
  piecesMap.put("blackBishop1", blackBishop1);
  piecesMap.put("blackBishop2", blackBishop2);
  piecesMap.put("whiteQueen1", whiteQueen1);
  piecesMap.put("blackQueen1", blackQueen1);
  piecesMap.put("whiteKing1", whiteKing1);
  piecesMap.put("blackKing1", blackKing1);
  piecesMap.put("whiteKnight1", whiteKnight1);
  piecesMap.put("whiteKnight2", whiteKnight2);
  piecesMap.put("blackKnight1", blackKnight1);
  piecesMap.put("blackKnight2", blackKnight2);
}

//Method to move piece using piecesMap Hashmap and using the .move to move the piece to desired spot. Passing in coordinates and piece.
void movePiece(int moveX, int moveY, String piece) {
 
 //Using .get accessor method  to get piece and move to new coordinates
  piecesMap.get(piece).move(moveX, moveY);
}

//Void method to display pieces currently in play
void displayAlivePieces() {
  // if the piece is in play, display it. Check if each piece in the hashmap has an alive value of true or not.
  for(Pieces value : piecesMap.values()) {
    if(value.getIsAlive()) { 	//If in play, then display
      value.display();     
    }    
  }
}

//Method to capture piece, passing in string of piece captured
void capturePiece(String pieceCaptured) {
  piecesMap.get(pieceCaptured).killPiece();	 //Ensuring the piece is no longer in play via hashmap and killPiece function
  
}

//Method for switching turns
void switchTurns() {
  if(turn.equals("white")) {
    turn = "black";
  }
  else {
    turn = "white";
  }
}

//Boolean method for capturing king
boolean capturingKing(int moveX, int moveY) {
  // ensure no moves capture the king
  if(!board[moveX/100-1][moveY/100-1].piece.equals("")) { 		//Checking not empty
  if(board[moveX/100-1][moveY/100-1].piece.substring(5,9).equals("King")) {	 //Checking if it’s a King
    return true;
  }
  }
  return false;
}


//Boolean to check if a move puts king in Danger
boolean puttingKingInDanger(int moveX, int moveY, String pieceName) {
  
  if(!pieceName.substring(5,9).equals("King")){ 	//Checking if it’s a king (to ensure it’s not)
   Pieces piece = piecesMap.get(pieceName);	//Setting up temp piece + Coordinates (below)
   int initialX = piece.getX();
   int initialY = piece.getY();
   String temporary = board[moveX/100-1][moveY/100-1].piece;

   if(!temporary.equals("")) {	//Checking if temporary isn’t empty
     if(piece.capturePossible(moveX, moveY)) {	//Checking if capture is possible
       piecesMap.get(temporary).killPiece();   	//Removing captured piece from play
    }    
   }
   // temporarily doing the move to see if the king will be in check if the move is done
   board[initialX/100-1][initialY/100-1].piece = "";	//Resetting piece at place to pieceName
   board[moveX/100-1][moveY/100-1].piece = pieceName;

   //Running through if the king will get checked for each color
   if(piece.getColour()=="white") {
     if(whiteKing1.willGetChecked(whiteKing1.getX(), whiteKing1.getY())) {
       //Turning square red if will get checked
       board[whiteKing1.getX()/100-1][whiteKing1.getY()/100-1].colour = #FF0000; 
       resetValues(pieceName, temporary, initialX, initialY, moveX, moveY); // calling the reset function to reset all temporary values in lines above
       return true;
     }    
   }
//Performing the same for black
   else {
     if(blackKing1.willGetChecked(blackKing1.getX(), blackKing1.getY())) {
       resetValues(pieceName, temporary, initialX, initialY, moveX, moveY); // calling the reset function to reset all temporary values in lines above
       return true;
     }  
     
   }
    resetValues(pieceName, temporary, initialX, initialY, moveX, moveY); // calling the reset function to reset all temporary values in lines above

  }
   return false;
}
 
//Void method for resetting values
 void resetValues(String temp1, String temp2, int initialX, int initialY, int moveX, int moveY) {
    board[initialX/100-1][initialY/100-1].piece = temp1;
     board[moveX/100-1][moveY/100-1].piece = temp2;  
     if(!temp2.equals("")) {
        piecesMap.get(temp2).makeAlive();
      
     }
    
  }
  
//Boolean method to check Checkmate
boolean checkCheckMate() {
  // Setting king variable to whatever color’s turn it is
  if(turn.equals("white")) {
     king = whiteKing1;
  }
  else {
     king = blackKing1;
  }
  if(king.willGetChecked(king.getX(), king.getY())) { //Checking if the king is currently in check
  
    board[king.getX()/100-1][king.getY()/100-1].colour = #FF0000; 	//Turning red
  int checkingPieceX = checkingPiece.getX();	//Getting coordinates of piece performing check
  int checkingPieceY = checkingPiece.getY();
  // if the checkingPiece can be captured, there is no possibility of a checkmate
      for(Pieces value : piecesMap.values()) {
    if(value.getIsAlive()) {	//Checking if alive
    if(value.getClass()==Pawn.class) { 	//if they are pawn
      if(value.capturePossible(checkingPieceX, checkingPieceY)) {	//If they can be captured
        return false;  
      }
    }
    else  {
      if(value.movePossible(checkingPieceX, checkingPieceY)) {
        return false;  	//If there is a move possible
      }  
    }
  }    
      }
      // Checking for a possibility for king to move around him -> Thus no checkmate
     if(king.movePossible(king.getX()+100, king.getY())) {
       return false;     
     }
     else if(king.movePossible(king.getX()-100, king.getY())) {
       return false;     
     }
      else if(king.movePossible(king.getX(), king.getY() + 100)) {
       return false;     
     }
       else if(king.movePossible(king.getX(), king.getY() - 100)) {
       return false;     
     }
       else if(king.movePossible(king.getX()+ 100, king.getY() + 100)) {
       return false;     
     }
       else if(king.movePossible(king.getX() + 100, king.getY() - 100)) {
       return false;     
     }
       else if(king.movePossible(king.getX() - 100, king.getY() - 100)) {
       return false;     
     }
       else if(king.movePossible(king.getX() - 100, king.getY() + 100)) {
       return false;     
     }

     //Checking if the check can be blocked -> Thus, no checkmate
     if(!(checkingPiece.getClass()==Knight.class || checkingPiece.getClass()==Pawn.class)) {   // pawn and knight checks cannot be blocked as they move over pieces / and directly diagonal
       if(checkingPiece.getClass()==Rook.class) { 	//Checking if the piece is a Rook
         if(checkRookBlock()) {	//Checking if it can be blocked
           return false;        
         }
}
     if(checkingPiece.getClass()==Bishop.class) {	//Checking if piece is a Bishop
       if(checkBishopBlock()) { //Checking if it can be blocked
         return false;
       }
     
  }
// if it is a queen check, check if it can be blocked by checking the rook or bishop check function depending on how the queen is behaving in the check


  else if(checkingPiece.getClass()==Queen.class) {   //Checking if piece is a Queen
if(checkingPiece.getX()/100==king.getX()/100 || checkingPiece.getY()/100==king.getY()/100) { 

      if(checkRookBlock()) {	//If the check can be blocked by checkRookBlock function
        return false;       
      }  
      else {
        if(checkBishopBlock()) { 	//If the check can be blocked by checkBishopBlock function
          return false;
        }
        //***HERE IS WHERE WE NEED TO ADD MORE POSSIBLE BLOCKS***
      }
    }
    
  }
     }
     return true;
  }
  return false;

}

//Boolean method to check if the rook can block a check
boolean checkRookBlock() {
        if(checkingPiece.getX()/100==king.getX()/100) { // if king and rook are on the same X file (line)
   int min = Math.min(checkingPiece.getY(), king.getY())/100; //Setting lower value between king and rook
   //Looping through all squares between the rook and king to see if any piece (same colour as king) is able to move and block the check

//looping each column
           for(int i = 1;i<Math.abs(checkingPiece.getY()/100-king.getY()/100);i++) { 
//checking each piece in hashmap
            for(Pieces value : piecesMap.values()) {

//check if the piece is alive and same colour as the king being checked
           if(value.getIsAlive() || value.getColour().equals(king.getColour())) {
             if(value.getClass()==Pawn.class) {

//if the piece that may be able to block is a pawn, check if blocking it stops check while making sure the king does not get put in check
               if(value.movePossible(king.getX(), (min+i)*100) && !(value.capturePossible(king.getX(), (min+i)*100))){
                 return true;
               }        
             }
//if the piece that may be able to block is a pawn, check if blocking it stops check while making sure the king does not get put in check

              else if(value.movePossible(king.getX(), (min+i)*100)) {
                 return true;  
      }  
      }             
           }       
           }
       }
       else if(checkingPiece.getY()/100==king.getY()/100) { // if king and rook are on the same Y file (line)
           int min = Math.min(checkingPiece.getX(), king.getX())/100;
           //Looping through all squares between the rook and king to see if any piece (same colour as king) is able to move and block the check (same as previous, but checking for rows instead of columns)

           for(int i = 1;i<Math.abs(checkingPiece.getX()/100-king.getX()/100);i++) {
            for(Pieces value : piecesMap.values()) {
           if(value.getIsAlive() && value.getColour().equals(king.getColour()) && !(value.getClass()==King.class)) {
             if(value.getClass()==Pawn.class) {
               if(value.movePossible((min+i)*100, king.getY()) && !(value.capturePossible((min+i)*100, king.getY()))) {
                 return true;              
               }
             }
             else if(value.movePossible((min+i)*100, king.getY())) {
              return true;  
      }  
      }             
           }       
           }
       }
       return false;
}


//Boolean method to check if the bishop can block a check
boolean checkBishopBlock() {
    int changeInX = king.getX()/100-checkingPiece.getX()/100;
    int changeInY = checkingPiece.getY()/100-king.getY()/100;
    int minX = Math.min(checkingPiece.getX()/100, king.getX()/100);
    int maxX = Math.max(checkingPiece.getX()/100,  king.getX()/100);
    int maxY = Math.max( checkingPiece.getY()/100, king.getY()/100);
    if(Math.abs(changeInX)==Math.abs(changeInY) && changeInX!=0 && changeInY!=0) { // if the x and y distance traveled are the same
     
      if(changeInX>0  && changeInY>0 || changeInX<0 && changeInY<0) {    // if bishop and king are on the same positive diagonal( y = x graph)  
      //Looping through all squares between the Bishop and king to see if any piece (same colour as king) is able to move and block the check
           for(int i = 1;i<Math.abs(changeInX);i++) {
            for(Pieces value : piecesMap.values()) {
//checking if the piece is alive, same colour as king, but not the king
           if(value.getIsAlive() && value.getColour().equals(king.getColour()) && !(value.getClass()==King.class)) {
//same as rook code. Checking pawn and pieces, but instead verifying they can move in between the diagonal (x and y coordinates) between king and bishop without putting king in check
             if(value.getClass()==Pawn.class) {
                if(value.movePossible((minX+i)*100, (maxY-i)*100) && !(value.capturePossible((minX+i)*100, (maxY-i)*100))) {
                  return true;
                }
             }
             else if(value.movePossible((minX+i)*100, (maxY-i)*100)) {
              return true;  
      }  
      }             
           }   
        }
    }
    }
    else { 
      // Looping through all squares between the Bishop and king to see if any piece (same colour as king) is able to move and block the check when the change in x and y is not the same (same as previous but checking rows and columns)
        for(int i = 1;i<Math.abs(changeInX);i++) {
            for(Pieces value : piecesMap.values()) {
           if(value.getIsAlive() && value.getColour().equals(king.getColour()) && !(value.getClass()==King.class)) {
             if(value.getClass()==Pawn.class) {
             if(value.movePossible((maxX-i)*100, (maxY-i)*100) && !(value.capturePossible((maxX-i)*100, (maxY-i)*100))) {
                  return true;
                }
             }
             else if(value.movePossible((maxX-i)*100, (maxY-i)*100)) {
              return true;  
      }             
           
      
      }
     }
}

}
return false;
}
