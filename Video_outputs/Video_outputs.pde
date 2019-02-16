import oscP5.*;
import processing.video.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;

Robot robot;
OscP5 oscP5;
Movie left;
Movie right;
Movie center;

boolean singleTrigger = true;
boolean a = false;
boolean b = false;
boolean c = false;

int delayTime = 100;
int lastClass = 0;
int currentClass = 0;

void setup() {
  //size(400, 400);
  fullScreen();

  oscP5 = new OscP5(this, 12000);

  right = new Movie(this, "03.mp4");
  left = new Movie(this, "02.mp4");
  center = new Movie(this, "01.mp4");
 
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(255);
  if (a) {
    center.play();
    image(center, 0, 0, width, height);
  }else{
    center.stop();
  }

  if (b) {
    left.play();
    image(left, 0, 0, width, height);
  }else{
    left.stop();
  }

  if (c) {
    right.play();
    image(right, 0, 0, width, height);
  }else{
    right.stop();
  }
}

void keyPressed(){
  if(key == "A"){
    
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    currentClass = (int) theOscMessage.get(0).floatValue();
    if (currentClass != lastClass) {

      if (currentClass == 1) { 
        println("center");
        a = true;
        b = false;
        c = false;
      }

      if (currentClass == 2) {
        println("left");
        b = true;
        a = false;
        c = false;
      }

      if (currentClass == 3) {
        println("right");
        c = true;
        a = false;
        b = false;
      }
      
      lastClass = currentClass;
    }
  }
}
