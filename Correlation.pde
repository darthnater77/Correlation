FloatTable popData, ipcData;

int topMargin, sideMargin;

void setup(){
  size(600,700);
  topMargin = 50;
  sideMargin = 150;
  
  //FloatTable popData = new FloatTable("");
  //FloatTable ipcData = new FloatTable("");
}

void draw(){
  background(255);
  stroke(0);
  
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
  
}

void population(){
  
}

void income(){
  
}
