FloatTable popData, ipcData;

int topMargin, sideMargin;
int current;
int rows, columns;
boolean zeros;

void setup(){
  size(600,700);
  topMargin = 50;
  sideMargin = 150;
  current = 0;
  
  zeros = false;
  
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
  sortData();
}

void columnLines(){
  line(sideMargin, 2*topMargin, sideMargin, height-topMargin+5);
  line(width-sideMargin, 2*topMargin, width-sideMargin, height-topMargin+5);
  text("Population",sideMargin,topMargin*1.5);
  text("Income Per Capita", width-sideMargin,topMargin*1.5);
}

void timeline(){
  int gap = (width-sideMargin)/columns;
  for (int i = 0; i < columns; i++){ 
    line(sideMargin/2+gap*(i+1),topMargin,sideMargin/2+gap*(i+1),topMargin+5);
    if(mouseX > sideMargin/2+gap*(i+.5) && mouseX < sideMargin/2+gap*(i+1.5) && mouseY > topMargin-20 && mouseY < topMargin+15)
      current = i;
    if (i == current)
      text(popData.getColumnName(i),sideMargin/2+gap*(i+1),topMargin/1.5);
  }
}

void sortData(){
  int y = 1;
  float[] sorted = new float[rows];
  float[] sortedIPC = new float[rows];
  for(int i = 0; i < rows; i++){
    sorted[i] = popData.getFloat(i, current);
    sortedIPC[i] = ipcData.getFloat(i, current);
    if (sortedIPC[i] == 0 && zeros == false)
      zeros = true;
    else if (sortedIPC[i] == 0)
      y++;
  }
  zeros = false;
  sorted = reverse(sort(sorted));
  sortedIPC = reverse(sort(sortedIPC));
  
  float popGap = (height - 3*topMargin)/(rows-1);
  float ipcGap = (height - 3*topMargin)/(rows-y);
  
  population(sorted, sortedIPC, popGap, ipcGap);
}

void population(float[] sorted, float[] sortedIPC, float popGap, float ipcGap){  
  float point;  
  for (int i = 0; i < rows; i++){
    textAlign(RIGHT, TOP);
    point = 2*topMargin+popGap*i;
    if (sorted[i] != 0)
      text(nf(sorted[i], 0, 0) + " ", sideMargin, point);
    else
      text("No Data ", sideMargin, point);
    for(int j = 0; j < rows; j++){
      if(sorted[i] == popData.getFloat(j, current)){
        textAlign(LEFT, TOP);
        text(popData.getRowName(j), 10, 2*topMargin+popGap*i);
        income(j, sortedIPC, ipcGap, point+5);
        j = rows;
      }
    }
  }
  zeros = false;
}

void income(int j, float[] dat, float gap, float point){
  for (int i = 0; i < rows; i++){
    if(ipcData.getFloat(j, current) == dat[i]){
      if(dat[i] != 0)
        text(dat[i], width-sideMargin, 2*topMargin+gap*i);
      else if (zeros == false){
        text(" No Data", width-sideMargin, 2*topMargin+gap*i);
        zeros = true;
      }
      line(sideMargin,point,width-sideMargin,2*topMargin+gap*i+5);
      i = rows;
    }
  }
}
