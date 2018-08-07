typedef unsigned int u_int;
const int BITS = (1<<3);
const int WSIZE = sizeof(u_int) * BITS;

u_int MASK[WSIZE*BITS];

void initMask(unsigned int MASK[]) {
    for(int i = 0; i < WSIZE * BITS;i++)
        MASK[i] = 1 << i;
}
/*
ifstream f("maze.txt");
bool getFromMatrixReading(){
    char c;
    f.getFromMatrix(c);
    return c=='1';
}
*/
// getReading stub, fill out with actual analog reading code
bool getReading(){
    return (rand() % 2) == 1;
}

const int ROWS = 4;
const int COLS = 96;
const int BINS = COLS / WSIZE;

u_int MATRIX[ROWS][BINS] = {0};

/*
for a 32bit number, this MATRIX looks like

          bin0        bin1        bin2 . . .
     ---------------------------------
row0 32bit_int   32bit_int   32bit_int . . .
row1 32bit_int   32bit_int   32bit_int . . .
row2 32bit_int   32bit_int   32bit_int . . .
.
.
.

*/
/**
 *
 * get the bin contains integer segment
 *
 * @param int @col This is the column number
 *
 * @return int returns the bin
 */
short getBin(int col) {
    // col / WSIZE will give you the current bin
    return col / WSIZE;
}
/**
 * get the integer mask for the current column in the correct bin
 */
u_int getMask(int index) {
    // col % WSIZE will give you the MASK for the current bin
    return MASK[index % WSIZE];
}

/**
 * return the mask for the given value
 */
u_int getMaskForValue(int index,int v) {
   return v?getMask(index):0;
}

/**
 * set the row and column value for the global matrix
 */
void setMatrix(int row,int col,bool v) {
    MATRIX[row][getBin(col)] |= getMaskForValue(col,v);
}
/**
 * get the row and column value in the global matrix
 */
bool getFromMatrix(int row,int col) {
   return MATRIX[row][getBin(col)] & getMask(col);
}

/**
 * scan the row in the given direction
 */
void scanRow(int row,char direction,int COLS) {
   if(direction == 'R') { // scans from left to right
       for(int col=0;col<COLS;col++) {
           setMatrix(row,col,getReading());
       }
   }
   else { // scans from right to left
       for(int col=COLS-1;col>=0;col--) {
           setMatrix(row,col,getReading());
       }
   }
}

/**
 * helper function to print out a given row
 */
void printRow(u_int row,int COLS) {
    for(int col=0;col < COLS;col++) {
       cout << getFromMatrix(row,col);
    }
    cout << endl;
}

int main()
{
    srand(time(0));
    initMask(MASK);
    for(int r=0;r < ROWS;r++) {
        scanRow(r,'R',COLS);
        printRow(r,COLS);
    }
    return 0;
}
