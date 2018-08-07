/*  Author:  Darrell Harriman 07/19/2014

When starting the game hit the Space Bar twice to make it run.

Conway's Game of Life
How it works:
Generate random ones and zeros to fill a grid (grid1).
grid2 cell values are calculated using the following rules.
A cell containing a 1 is alive.  A cell containing a 0 is dead.
If a cell contains a 1 (is live) and has 2 or 3 live neighbors it stays alive.
If a cell contains a 0 (is dead) and has exactly 3 live neighbors it spawns a new life.
All other neighbor counts result in dead cells from overpopulation or loneliness.
Neighbor cells are adjacent cells either horizontally, vertically or diagonally.
The table wraps left to right and top to bottom.
Far right and far left column cells are neighbors. 
Top row and bottom row cells are neighbors.
Every cell has exactly 8 neighbors.
After grid2 is calculated and displayed, grid1 cell values will be calculated using grid2 values.
grid1 is then displayed on the screen. 
The display alternantes between grid1 and grid2.
When grid1 or grid2 stop changing the game will pause.
On rare occasions it may falsely sense that a grid stopped changing.  Press space bar twice to resume.
The Space bar will pause and resume the game.
Search Wikipedia for more information about Conway's game of life.
*/
// You may change the number of rows, columns and the update rate as desired.
// Grid sizes smaller than 7 rows x 7 columns don't work well.

int rows = 96, cols = 192;  //96 rows x 128 columns fits nicely on a large screen
int updaterate = 5;  //Number of frames per second to display. 5 works well.
//******************************************************************************
boolean G1_2 = true, pause = false;
boolean[][] grid1 = new boolean[rows][cols];
boolean[][] grid2 = new boolean[rows][cols];
int osc1c = 0, osc1r = 0, osc2c = 0, osc2r = 0;
//******************************************************************************
void setup()
{
  //size((cols + 1) * 8, (rows + 1) * 8 + 8);
  size((cols * 8), (rows * 8 + 12));
  //size((cols + 1) * 16, (rows + 1) * 16);
  frame.setTitle("Conway's Game of Life");
  frameRate(updaterate);
  background(0);
//  stroke(255);
  
  randomGrid1();
  noLoop();
  displayGrid2();
//Test functions for development.  Not required for game to run.
  print("Rows: " + rows);
  println("  Columns: " + cols); 
  println("Neighbors for Cell Grid1[0][0]: " + census1(0, 0));
  println("Neighbors for Cell Grid1[" + (rows-1) + "][" + (cols-1) + "]: " + census1(rows-1, cols-1));
//End of Test functions for development.  
}
//******************************************************************************
void draw()
{
  if(G1_2)
  {
    displayGrid1();
    print(".");  //Optional line used for game development.
  }
  else
  {
    displayGrid2();
    print(":");  //Optional line used for game development.
  }
  G1_2 = !G1_2;  //Toggle so grid1 and grid2 alternate.
//  delay(updatetime);    //100 milliSecond delay between each update
}
//******************************************************************************
//Fill random 1s and 0s in grid1 to initialize game.
void randomGrid1()
{
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < cols; j++)
      {   
        int TEMP = int(random(255));
        grid1[i][j] = (TEMP > 127);
      }
  }
}
//******************************************************************************
//Calculate number of live neighbors to a cell in grid1
//Testing for first or last column to make last or first column neighbors.
int census1(int row, int col)
  {
    int Pop = 0; 
    int lcol, rcol, trow, brow;
    if(col == (cols - 1)) { 
        lcol = col - 1;
        rcol = 0;        
      }
      else if(col ==  0) {
        lcol = cols - 1;
        rcol = col + 1;
      }
      else {
        lcol = col - 1;
        rcol = col + 1;        
      }
//Testing for first or last row to make last or first row neighbors.      
    if(row == (rows - 1)) { 
        trow = row - 1;
        brow = 0;
      }
      else if(row ==  0) {
        trow = rows - 1;
        brow = row + 1;
      }
      else {
        trow = row - 1;
        brow = row + 1;        
      }

    if(grid1[trow][lcol]) Pop ++;  //Top Left
    if(grid1[trow][col]) Pop ++;   //Top Center
    if(grid1[trow][rcol]) Pop ++;  //Top Right
    if(grid1[row][lcol]) Pop ++;   //Middle Left
    if(grid1[row][rcol]) Pop ++;   //Middle Right
    if(grid1[brow][lcol]) Pop ++;  //Bottom Left
    if(grid1[brow][col]) Pop ++;   //Bottom Center
    if(grid1[brow][rcol]) Pop ++;  //Bottom Right

/*  //Optional algorithm for calculating number of live neighbors.  
    //Modulo function used to wrap grid columns and rows.
    if(grid1[(row + rows - 1) % rows][(col + cols - 1) % cols]) Pop ++;  //Top Left
    if(grid1[(row + rows - 1) % rows][col]) Pop ++;              //Top Center
    if(grid1[(row + rows - 1) % rows][(col + 1) % cols]) Pop ++;   //Top Right
    if(grid1[row][(col + cols - 1) % cols]) Pop ++;              //Middle Left
    if(grid1[row][(col + 1) % cols]) Pop ++;               //Middle Right
    if(grid1[(row + 1) % rows][(col + cols - 1) % cols]) Pop ++;   //Bottom Left
    if(grid1[(row + 1) % rows][col]) Pop ++;               //Bottom Center
    if(grid1[(row + 1) % rows][(col + 1) % cols]) Pop ++;     //Bottom Right
*/
    return Pop;
  }
//******************************************************************************
//Calculate number of live neighbors to a cell in grid2
//Testing for first or last column to make last or first column neighbors.
int census2(int row, int col)
  {    
    int Pop = 0;
    int lcol, rcol, trow, brow;
    if(col == (cols - 1)) { 
        lcol = col - 1;
        rcol = 0;        
      }
      else if(col ==  0) {
        lcol = cols - 1;
        rcol = col + 1;
      }
      else {
        lcol = col - 1;
        rcol = col + 1;        
      }
//Testing for first or last row to make last or first row neighbors.       
    if(row == (rows - 1)) { 
        trow = row - 1;
        brow = 0;
      }
      else if(row ==  0) {
        trow = rows - 1;
        brow = row + 1;
      }
      else {
        trow = row - 1;
        brow = row + 1;        
      }

    if(grid2[trow][lcol]) Pop ++;  //Top Left
    if(grid2[trow][col]) Pop ++;   //Top Center
    if(grid2[trow][rcol]) Pop ++;  //Top Right
    if(grid2[row][lcol]) Pop ++;   //Middle Left
    if(grid2[row][rcol]) Pop ++;   //Middle Right
    if(grid2[brow][lcol]) Pop ++;  //Bottom Left
    if(grid2[brow][col]) Pop ++;   //Bottom Center
    if(grid2[brow][rcol]) Pop ++;  //Bottom Right

/*  //Optional algorithm for calculating number of live neighbors.  
    //Modulo function used to wrap grid columns and rows.
    if(grid2[(row + rows - 1) % rows][(col + cols - 1) % cols]) Pop ++;  //Top Left
    if(grid2[(row + rows - 1) % rows][col]) Pop ++;              //Top Center
    if(grid2[(row + rows - 1) % rows][(col + 1) % cols]) Pop ++;   //Top Right
    if(grid2[row][(col + cols - 1) % cols]) Pop ++;              //Middle Left
    if(grid2[row][(col + 1) % cols]) Pop ++;               //Middle Right
    if(grid2[(row + 1) % rows][(col + cols - 1) % cols]) Pop ++;   //Bottom Left
    if(grid2[(row + 1) % rows][col]) Pop ++;               //Bottom Center
    if(grid2[(row + 1) % rows][(col + 1) % cols]) Pop ++;     //Bottom Right
*/
    return Pop;
  }
//******************************************************************************
//Update Grid1 and Display on Screen
void displayGrid1()
{
  int colsum = 0, rowsum = 0;
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < cols; j++)
      {
        int TEMP = census2(i, j);
        grid1[i][j] = ((TEMP == 3) || (grid2[i][j] && ( TEMP == 2)));        
        if(grid1[i][j]) { 
          fill(20, 20, 255);
          colsum += j;
          rowsum += i;
          }
        else {fill(0);
          }    
        noStroke();
        ellipse(j*8+4,i*8+4, 7, 7);
      }
  }
  //Testing for no growth/decline.  Oscillations only.
  if((colsum == osc1c) && (rowsum == osc1r)) noLoop();
  osc1c = colsum;
  osc1r = rowsum; 
  fill(0);
  rect(50, height - 14, 60, 15);
  textSize(14);
  fill(255);
  text(frameCount, 50, height - 3);
}
//******************************************************************************
//Update Grid2 and Display on Screen
void displayGrid2()
{
  int colsum = 0, rowsum = 0;
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < cols; j++)
      {
        int TEMP = census1(i, j);
        grid2[i][j] = ((TEMP == 3) || (grid1[i][j] && ( TEMP == 2)));        
        if(grid2[i][j]) { 
          fill(40, 20, 240);
          colsum += j;
          rowsum += i;
          }
        else {fill(0);
          }    
        noStroke();
        //ellipse((j+1)*8,(i+1)*8, 7, 7);
        ellipse(j*8+4,i*8+4, 7, 7);
      }
  }
  //Testing for no growth/decline.  Oscillations only.
  if((colsum == osc2c) && (rowsum == osc2r)) noLoop();
  osc2c = colsum;
  osc2r = rowsum;
  
  fill(0);
  rect(50, height - 14, 60, 15);
  textSize(14);
  fill(255);
  text(frameCount, 50, height - 3);
}
//******************************************************************************
void keyPressed()
{
  if(key == ' ')
    {
      pause = !pause;
      if(pause)
      {
        noLoop();        
        println(frameCount);
      }
      else
      {
        loop();
      } 
    }
}
