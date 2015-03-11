FloatTable popData, ipcData;

int topMargin, sideMargin;
int current;
int rows, columns;

void setup(){
  size(600,700);
  topMargin = 50;
  sideMargin = 150;
  current = 0;
  
  popData = new FloatTable("WorldData.tsv");
  ipcData = new FloatTable("WorldIncome.tsv");
  
  rows = popData.getRowCount();
  columns = ipcData.getColumnCount();
}

void draw(){
  background(255);
  stroke(0);
  fill(0);
  textAlign(CENTER, TOP);
  
  lines();
  timeline();
  population();
  income();
}

void lines(){
  line(sideMargin, 2*topMargin, sideMargin, height-topMargin);
  line(width-sideMargin, 2*topMargin, width-sideMargin, height-topMargin);
}

void timeline(){
  int gap = (width-sideMargin)/columns;
  for (int i = 0; i < columns; i++){ 
    line(sideMargin/2+gap*(i+1),topMargin,sideMargin/2+gap*(i+1),topMargin+5);
    if(mouseX > sideMargin/2+gap*(i+.5) && mouseX < sideMargin/2+gap*(i+1.5) && mouseY > topMargin-10 && mouseY < topMargin+15)
      current = i;
    if (i == current)
      text(popData.getColumnName(i),sideMargin/2+gap*(i+1),topMargin/1.5);
  }
}

void population(){
  
}

void income(){
  
}
