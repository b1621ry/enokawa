//invisible window bar
//////////////////////////////////////////////////////////////////////////////////////
public void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();
}

//libraries
//////////////////////////////////////////////////////////////////////////////////////
import processing.video.*;
import jp.nyatla.nyar4psg.*;
import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

//int,float,
//////////////////////////////////////////////////////////////////////////////////////
//ar
Capture cam;
MultiMarker ar_ar;
int id;//marker ID
int id2;//marker ID2

//time
int time;
int current_time;

//sound
Minim minim;
AudioPlayer song1;
AudioPlayer song2;
AudioPlayer song3;

//saving int
PImage img;
PImage logo;
PImage a;
PImage b;
PImage mask;
int i;
int j;
int demention;



//fileCount
int flag;

//font
PFont aaa;
//////////////////////////////////////////////////////////////////////////////////////
void setup(){
  size(640,480,P3D);
  colorMode(RGB,255,255,255,255);
  cam = new Capture(this, width, height);
  
  //preparing AR
  ar_ar = new MultiMarker(this, width, height, "camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  id = ar_ar.addARMarker("up.pat",35);
  id2 = ar_ar.addARMarker("down.pat",35);
  
  //preparing sound
  minim = new Minim(this);
  song1 = minim.loadFile("sound1.mp3");
  song2 = minim.loadFile("sound1.mp3");
  song3 = minim.loadFile("sound1.mp3");
  
  //time count
  time = 0;
  current_time = 0;
  
  //file count
  i = fileCount() +1;
  print(i);
  
  //font
  PFont font = createFont("Chalkboard",20);
  textFont(font);
  
  
}

//////////////////////////////////////////////////////////////////////////////////////
void draw(){
  if(cam.available()==false) return;
  
  cam.read();
  background(0);
  ar_ar.drawBackground(cam);
  ar_ar.detect(cam);
  
  //guide rect
  stroke(88,220,242,80);
  strokeWeight(4);
  fill(88,220,242,30);
  rect(30,30,150,150);
  rect(460,300,150,150);
  
  //guide font
  fill(15,140,240);
  text("<<< Place the marker here",190,60);
  fill(15,140,240);
  text("Place the marker here >>>",220,430);
  
  if(ar_ar.isExistMarker(id) && ar_ar.isExistMarker(id2)){
    
    PVector pos1 = getCenterOfMarker(id);
    PVector pos2 = getCenterOfMarker(id2);
    
    ar_ar.beginTransform(id);
    fill(100,160,240,200);
    translate(0,0,15);
    box(30);
    ar_ar.endTransform();
    
    ar_ar.beginTransform(id2);
    fill(100,160,240,100);
    translate(0,0,15);
    box(30);
    ar_ar.endTransform();
    
    
    
    
    if(pos1.x<150 && 
      pos2.x>490 && 
      pos1.y<150 &&
      pos2.y>330 &&
      time>200 
       ){
       ar_ar.drawBackground(cam);
       String savePic = "enokawa"+i+".png";
       filter(THRESHOLD,0.5);
       
       a  = get(int(pos1.x+50),int(pos1.y),int(pos2.x-pos1.x-100),int(pos2.y-pos1.y));
       b  = get(int(pos1.x+50),int(pos1.y),int(pos2.x-pos1.x-100),int(pos2.y-pos1.y));
       a.loadPixels();
       demention = (a.width*a.height);
       //gazou hanten
       for(int j = 0; j<demention ; j++){
         if(a.pixels[j]==color(255,255,255)){
           a.pixels[j]=color(0,0,0);
         }else if(a.pixels[j]==color(0,0,0)){
           a.pixels[j]=color(255,255,255);
         }
       }
       a.updatePixels();
       
       mask = a;
       b.mask(a);
       b.save("../enokawa/data/" + savePic);//saving
       song2.play();//ring a tone
       print("done saving");
       
       time = 0;
       i++;
       song2.rewind();
       }
  }
 time++;
}

/////////////////////////////////////////////////////////////////////////////////////////
PVector getCenterOfMarker(int id){
  PVector[] vec = ar_ar.getMarkerVertex2D(id);
  return new PVector((vec[0].x + vec[2].x)/2,(vec[0].y + vec[2].y)/2);
}
/////////////////////////////////////////////////////////////////////////////////////////
int fileCount(){
  int fileNum =1;
  while(flag == 0){
    if(loadImage("../enokawa/data/"+"enokawa" + (fileNum) + ".png")!=null){
      fileNum++;
    }else{
      flag = 1;
    }
  }
  return fileNum-1;
}
/////////////////////////////////////////////////////////////////////////////////////////




