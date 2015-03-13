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
  
  textSize(12);
  columnLines();
  timeline();
  textSize(10);
  population();
}

void columnLines(){
  line(sideMargin, 2*topMargin, sideMargin, height-topMargin);
  line(width-sideMargin, 2*topMargin, width-sideMargin, height-topMargin);
  text("Population",sideMargin,topMargin*1.5);
  text("Income Per Capita", width-sideMargin,topMargin*1.5);
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
  float gap = (height - 3*topMargin)/(rows-1);
  float point;
  for (int i = 0; i < rows; i++){
    textAlign(LEFT, TOP);
    text(popData.getRowName(i), 10, 2*topMargin+gap*i);
    textAlign(RIGHT, TOP);
    point = 2*topMargin+gap*i;
    text(nf(popData.getFloat(i, current), 0, 0) + " ", sideMargin, point);
    income(i, gap, point+5);
  }
}

void income(int i, float gap, float point){
  textAlign(LEFT, TOP);
  text(ipcData.getFloat(i, current), width-sideMargin, 2*topMargin+gap*i);
  line(sideMargin,point,width-sideMargin,2*topMargin+gap*i+5);
}
