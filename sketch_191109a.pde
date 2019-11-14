import processing.serial.*;
import cc.arduino.*;
import processing.sound.*;
import processing.io.*;

SoundFile kick, hihat, file1, file2;
Arduino arduino;

int potPin1 = 0;
int potVal1 = 0;

int potPin2 = 1;
int potVal2 = 0;

int potPin3 = 1;
int potVal3 = 0;

SoftwareServo servo;
int potpin = 0;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin

void setup() {
  size(640, 360);
  background(255);
  
  arduino = new Arduino(this, "/dev/cu.usbmodem14201", 57600);
  kick = new SoundFile(this, "kick.wav");
  hihat = new SoundFile(this, "Hi Hat Closed.mp3");
  file1 = new SoundFile(this, "sample3.wav");
  file2 = new SoundFile(this, "sample1.wav");
  
  println(Arduino.list());
  
  servo = new SoftwareServo(this);
  servo.attach(4);


  
 }      

void draw() {
  potVal1 = arduino.analogRead(potPin1);
  potVal2 = arduino.analogRead(potPin2);
  potVal3 = arduino.analogRead(potPin3);
  println("value 1:" + potVal1);
  println("value 2:" + potVal2);
  if (potVal1 > 100){
    kick.play();
    delay(300);
  }
  
  if (potVal2 > 100){
    hihat.play();
    delay(300);
  }
  
  if (potVal3 > 10){
    file1.play();
    delay(300);
    //file2.play();
  }
  
  val = arduino.analogRead(potPin3);            // reads the value of the potentiometer (value between 0 and 1023)
  val = val/5;   // scale it to use it with the servo (value between 0 and 180)
  servo.write(val);                  // sets the servo position according to the scaled value
  delay(15);                           // waits for the servo to get there
}
