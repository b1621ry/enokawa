/*public void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();
}*/
/////////////////////////////////////////////////////////////////////////////////////////
PImage newPhoto;
PImage[] photo = new PImage[1];

int time =0;
//Number of Images
int imgNum = 1;
int randNum = 0;
int newImageFlag = 0;

int newImage_x = int(random(0, 700));
int newImage_y = 600;

ArrayList imgObjects;

int enokawaX = 2000;
int enokawaY = 1000;

/////////////////////////////////////////////////////////////////////////////////////////
class imageMove {
  int x;
  int y;
  int w;
  int h;
  
  int ran_flag;
  
  float theta;
  
  PImage Img;

  imageMove(int imgNum,int time) {
    x = 0;
    if(time % 2 == 0 ){
    y = int(random(2, 10)) * 50;
    }else{
     y = int(random(11 ,18)) * 50;
    }
   
    w = 150;
    h = 150;
    
    theta = 0;
   
    Img = loadImage("enokawa" + (imgNum) + ".png");
  }
/////////////////////////////////////////////////////////////////////////////////////////
  void update(int time) {
    theta += 0.1;
    if(ran_flag == 0){
      y = y + int(sin(theta)* int(random(1,4)));
    }else{
      y = y + int(cos(theta)* int(random(1,4)));
    }
    x += int(random(3, 5));
   
    //image wo byousha
    plot();
    
    
    if (x > enokawaX) {  
      x =0;
      if(time % 2 == 0 ){
        y = int(random(2, 10)) * 50;
      }else if(time % 2 == 1){
        y = int(random(11, 18)) * 50;
      }
    }
  }
 
  void plot() { 
      image(Img, x, y, w, h);
  }
}
/////////////////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(enokawaX, enokawaY);
  imgObjects = new ArrayList();
  imgObjects.add(new imageMove(imgNum,time)); 
}
/////////////////////////////////////////////////////////////////////////////////////////

int objSize;

void draw()
{
 //setbackgroundcolor 
  background(255);
  
  //imageobjects wo zenbu sousa
  objSize = imgObjects.size();
  if(objSize < 12){
    for(int i=0;i < imgObjects.size();i++){
      imageMove img1 = (imageMove)imgObjects.get(objSize-1);
      img1.update(time); 
      objSize -= 1;
    }
  }else{
    for(int i=0;i < 12;i++){
      imageMove img1 = (imageMove)imgObjects.get(objSize-1);
      img1.update(time); 
      objSize -= 1;
      
    }
    
  }
  
  if (newImageFlag == 1) {

    image(newPhoto, newImage_x, newImage_y, 300, 300);
    
    if (newImage_y > 100) {
      newImage_y = newImage_y -2;
    }

    if (newImage_x <= enokawaX) {
      newImage_x +=5;
      if (newImage_x > enokawaX) {
        newImageFlag = 0; 
        imgNum ++;
        newImage_x = int(random(enokawaX/5, enokawaX-2*enokawaX/3));
        newImage_y = enokawaY;
        
        imgObjects.add(new imageMove(imgNum,time));
      }
    }
    
  }

  time++;

  if (time == 100) {
    newFileGet();
    time = 0;
  }  
}

/////////////////////////////////////////////////////////////////////////////////////////
void newFileGet() {   
  if (loadImage("enokawa" + (imgNum+1) + ".png") != null) {
    newPhoto = loadImage("enokawa" + (imgNum+1) + ".png");
    newImageFlag = 1;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
