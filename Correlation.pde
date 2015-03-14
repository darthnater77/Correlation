FloatTable popData, ipcData;
Integrator[] positions, positions2;

int topMargin, sideMargin;
int current;
int rows, columns;
boolean zeros;
float[] sorted, sortedIPC;
float popGap, ipcGap;

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
  popGap = (height - 3*topMargin)/(rows-1);
  
  sorted = new float[rows];
  sortedIPC = new float[rows];
  
  setupIntegrator();
  update();
}

void setupIntegrator(){
  float gap = (height - 3*topMargin)/(rows-1);
  positions = new Integrator[rows];
  positions2 = new Integrator[rows];
  for (int i = 0; i < rows; i++){
    positions[i] = new Integrator(2*topMargin);
    positions2[i] = new Integrator(2*topMargin);
  }
}

void draw(){
  background(255);
  stroke(0);
  fill(0);
  textAlign(CENTER, TOP);
  
  for(int i = 0; i < rows; i++)
    positions[i].update();
  
  textSize(12);
  columnLines();
  timeline();
  textSize(10);
  drawData();
  
  for (int i = 0; i < rows; i++){
    positions[i].update();
    positions2[i].update();
  }
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
    if(mouseX > sideMargin/2+gap*(i+.5) && mouseX < sideMargin/2+gap*(i+1.5) && mouseY > topMargin-20 && mouseY < topMargin+15 && current != i){
      current = i;
      update();
    }
    if (i == current)
      text(popData.getColumnName(i),sideMargin/2+gap*(i+1),topMargin/1.5);
  }
}

void update(){
  int y = 1;
  for(int i = 0; i < rows; i++){
    sorted[i] = popData.getFloat(i, current);
    sortedIPC[i] = ipcData.getFloat(i, current);
    if (sortedIPC[i] == 0)
      y++;
  }
  zeros = false;
  sorted = reverse(sort(sorted));
  sortedIPC = reverse(sort(sortedIPC));  
  if (y > 1)
    y--;
  ipcGap = (height - 3*topMargin)/(rows-y);
}

void drawData(){
  for (int i = 0; i < rows; i++){
    textAlign(RIGHT, TOP);    
    for(int j = 0; j < rows; j++){
      if(sorted[i] == popData.getFloat(j, current)){
        positions[j].target(2*topMargin+popGap*i);
        text(checkData(sorted[i], true), sideMargin, positions[j].value);  
        textAlign(LEFT, TOP);
        text(popData.getRowName(j), 10, positions[j].value);
        incomeData(j);
        j = rows;
      }
    }
  }
  zeros = false;
}

void incomeData(int j){  
  for (int i = 0; i < rows; i++){
    if(ipcData.getFloat(j, current) == sortedIPC[i]){
      positions2[j].target(2*topMargin+ipcGap*i);
      text(checkData(sortedIPC[i], false), width-sideMargin, positions2[j].value);
      drawLine(positions[i].value+5, positions2[i].value+5);
      i = rows;
    }
  }
}

void drawLine(float point1, float point2){
  if(point1 < point2)
    stroke(255,0,0);
  else
    stroke(0,0,255);
  line(sideMargin,point1,width-sideMargin,point2);
}

String checkData(float x, boolean right){
  if(!right){
    if (x == 0)
      if (!zeros){
        zeros = true;
        return " No Data ";
      }
      else
        return "";
    else
      return " " + x;
  }
  else{
    if (x == 0)
      return " No Data ";
    else
      return nf(x, 0, 0) + " ";
  }
}
