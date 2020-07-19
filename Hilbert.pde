int order = 8;
int n = (int)pow(2, order);
int total = n * n;

PVector[] path;

PImage img;

void setup(){
  size(1024, 1024, P3D);
  
  background(0);
  
  path = new PVector[total];
  
  for(int i = 0; i < total; i++){
    path[i] = hilbert(i);
    float len = width / n;
    path[i].mult(len);
    path[i].add(len / 2, len / 2);
  }
  
  img = loadImage("container.png");
}

int counter = 0;

void draw(){
  background(0);
  
  strokeWeight(2);
  noFill();
  beginShape();
  for(int i = 0; i < total; i++){
    //float h = map(i, 0, path.length, 0, 360);
    //stroke(h, 255, 255);
    int x = (int)map(path[i].x, 0, width, 0, img.width);
    int y = (int)map(path[i].y, 0, height, 0, img.height);
    int loc = x + (y * img.width);
    color c = img.pixels[loc];
    float val = (red(c) + green(c) + blue(c)) / 3;
    stroke(val, val, val);
    vertex(path[i].x, path[i].y); 
  }
  endShape();
}

PVector hilbert(int i){
  PVector[] points = {
    new PVector(0, 0),
    new PVector(0, 1),
    new PVector(1, 1),
    new PVector(1, 0)
  };
  
  int index = i & 3;
  PVector v = points[index];
  
  for(int j = 1; j < order; j++){
    i = i >>> 2;
    index = i & 3;
    
    float len = pow(2, j);
    
    if(index == 0){
      float tmpX = v.x;
      v.x = v.y;
      v.y = tmpX;
    }
    else if(index == 1){
      v.y += len;
    }
    else if(index == 2){
      v.x += len;
      v.y += len;
    }
    else if(index == 3){
      float tmpX = len - 1 - v.x;
      v.x = len - 1 - v.y;
      v.y = tmpX;
      
      v.x += len; 
    }
  }
  
  return v;
}
