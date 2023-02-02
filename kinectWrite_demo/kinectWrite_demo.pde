/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/
 KinectPV2, Kinect for Windows v2 library for processing
 Skeleton color map example.
 Skeleton (x,y) positions are mapped to match the color Frame
 */

import KinectPV2.KJoint;
import KinectPV2.*;

FloatList handx;
FloatList handy;
FloatList handz;
FloatList handx_left;
FloatList handy_left;
FloatList handz_left;
int sketchID = 0;
int bodies = 0;

KinectPV2 kinect;

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

// Enable 3d  with (x,y,z) position
  kinect.enableSkeleton3DMap(true);

  kinect.init();
  
  handx = new FloatList();
  handy = new FloatList();
  handz = new FloatList();
  handx_left = new FloatList();
  handy_left = new FloatList();
  handz_left = new FloatList();
}

void draw() {
  background(1);
  colorMode(HSB, 100, 100, 100, 100);

// If you want to see the RGB image from HD Camera
  //image(kinect.getColorImage(), 0, 0, width, height);

// Get the depth image data
  //rawDepth = kinect.getDepthMaskImage();

// Get the 2D array data points from the Skeleton Color Map  
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

      bodies = skeletonArray.size();

// Get the Skeleton data joints (X & Y only)

  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
     
      //HALM: add positions to lists
      handx.append(joints[HAND_RIGHT].getX());
      handy.append(joints[HAND_RIGHT].getY());
      handx_left.append(joints[HAND_LEFT].getX());
      handy_left.append(joints[HAND_LEFT].getY());
      
      if (bodies != skeletonArray.size()) {
        bodies = skeletonArray.size();
        sketchSwitch(sketchID, bodies);
      }
      
      if (handx.size() > 1000){
        handx.clear();
        handy.clear();
        handx_left.clear();
        handy_left.clear();
    //    sketchID = (sketchID + 1)%12; //rotate sketches
      }
    } 
  }
  
// Get the 3D data points from the 3D skeleton (access to Z point)
  ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();

  for (int i = 0; i < skeleton3DArray.size(); i++) {
    KSkeleton skeleton3D = (KSkeleton) skeleton3DArray.get(i);
    if (skeleton3D.isTracked()) {
      KJoint[] joints3D = skeleton3D.getJoints();

      //HALM: z positions
      handz.append(joints3D[HAND_RIGHT].getZ());
      handz_left.append(joints3D[HAND_LEFT].getZ());
    
      if (handz.size() > 1000){
        handz.clear();
        handz_left.clear();
      }
    }
  }
  
  sketchSwitch(sketchID, bodies); //pick a sketch

}

void sketchSwitch(int sketchID, int bodies) {
switch(sketchID) {
  case 0:
    drawDots(bodies);
    break;
  case 1:
    drawLines(bodies);
    break;
  case 2:
    drawSpeed(bodies);
    break;
  case 3:
    drawZigzag(bodies);
    break;
  case 4:
    drawSpeed2(bodies);
    break;
  case 5:
    drawSpread(bodies);
    break;
  case 6:
    drawAvg(bodies);
    break;
  case 7:
    drawDepth(bodies);
    break;
  case 8:
    drawTime(bodies);
    break;
  case 9:
    drawZigzag(bodies);
    drawLines(bodies);
    break;
  case 10:
    drawSpeed2(bodies);
    drawAvg(bodies);
    break;
  case 11:
    drawTime(bodies);
    drawSpread(bodies);
    break;
  }
}

void drawDots(int bodies) {
 for (int n = bodies; n<handx.size(); n++) {
    float a_x = handx.get(n);
    float a_y = handy.get(n);
    float b_x = handx.get(n - bodies);
    float b_y = handy.get(n - bodies);
    float dist = sqrt(sq(a_x-b_x)+sq(a_y-b_y));
    noStroke();
    fill(dist%100, 100, 100);
    ellipse(a_x,a_y,(dist/3)+2,(dist/3)+2);
    float a_x_left = handx_left.get(n);
    float a_y_left = handy_left.get(n);
    float b_x_left = handx_left.get(n - bodies);
    float b_y_left = handy_left.get(n - bodies);
    float dist_left = sqrt(sq(a_x_left-b_x_left)+sq(a_y_left-b_y_left));
    noStroke();
    fill(dist_left%100, 100, 100);
    ellipse(a_x_left,a_y_left,(dist_left/3)+2,(dist_left/3)+2);
  }
}

void drawLines(int bodies) {
  for (int n = bodies; n<handx.size(); n++) {
    stroke(100);
    strokeWeight(10);
    float a_x = handx.get(n);
    float a_y = handy.get(n);
    float b_x = handx.get(n-bodies);
    float b_y = handy.get(n-bodies);
    line(b_x,b_y,a_x,a_y);
    float a_x_left = handx_left.get(n);
    float a_y_left = handy_left.get(n);
    float b_x_left = handx_left.get(n-bodies);
    float b_y_left = handy_left.get(n-bodies);
    line(b_x_left,b_y_left,a_x_left,a_y_left);      
  }
}

void drawSpeed(int bodies) {
  for (int n = bodies; n<handx.size(); n++) {
        float a_x = handx.get(n);
        float a_y = handy.get(n);
        float b_x = handx.get(n-bodies);
        float b_y = handy.get(n-bodies);
        float dist = sqrt(sq(a_x-b_x)+sq(a_y-b_y));
        stroke(dist%100, 100, 100);
        strokeWeight(10);
        line(b_x,b_y,a_x,a_y);
        float a_x_left = handx_left.get(n);
        float a_y_left = handy_left.get(n);
        float b_x_left = handx_left.get(n-bodies);
        float b_y_left = handy_left.get(n-bodies);
        float dist_left = sqrt(sq(a_x_left-b_x_left)+sq(a_y_left-b_y_left));
        stroke(dist_left%100, 100, 100);
        strokeWeight(10);
        line(b_x_left,b_y_left,a_x_left,a_y_left);
  }
}

void drawSpeed2(int bodies) {
  for (int n = bodies; n<handx.size(); n++) {
        float a_x = handx.get(n);
        float a_y = handy.get(n);
        float b_x = handx.get(n-bodies);
        float b_y = handy.get(n-bodies);
        float dist = sqrt(sq(a_x-b_x)+sq(a_y-b_y));
        stroke(dist%100, 100, 100);
        strokeWeight(dist/10);
        line(b_x,b_y,a_x,a_y);
        float a_x_left = handx_left.get(n);
        float a_y_left = handy_left.get(n);
        float b_x_left = handx_left.get(n-bodies);
        float b_y_left = handy_left.get(n-bodies);
        float dist_left = sqrt(sq(a_x_left-b_x_left)+sq(a_y_left-b_y_left));
        stroke(dist_left%100, 100, 100);
        strokeWeight(dist/10);
        line(b_x_left,b_y_left,a_x_left,a_y_left);
  }
}

void drawSpread(int bodies) {
  for (int n = bodies; n<handx.size(); n++) {
    float a_x = handx.get(n);
    float a_y = handy.get(n);
    float b_x = handx.get(n-bodies);
    float b_y = handy.get(n-bodies);
    float a_x_left = handx_left.get(n);
    float a_y_left = handy_left.get(n);
    float dist = sqrt(sq(a_x-a_x_left)+sq(a_y-a_y_left));
    stroke((dist/12)%100, 100, 100);
    strokeWeight(10);
    line(b_x,b_y,a_x,a_y);
  }
}

void drawDepth(int bodies) {
 for (int n = bodies; n<handx.size(); n++) {
    float a_x = handx.get(n);
    float a_y = handy.get(n);
    float b_x = handx.get(n-bodies);
    float b_y = handy.get(n-bodies);
    float z = handz.get(n);
    stroke(z*30%100, 100, 100);
    strokeWeight(z*10);
    line(b_x,b_y,a_x,a_y);
    float a_x_left = handx_left.get(n);
    float a_y_left = handy_left.get(n);
    float b_x_left = handx_left.get(n-bodies);
    float b_y_left = handy_left.get(n-bodies);
    float z_left = handz_left.get(n);
    stroke(z_left*30%100, 100, 100);
    strokeWeight(z_left*10);
    line(b_x_left,b_y_left,a_x_left,a_y_left);
  }
}

void drawTime(int bodies) {
  float r = 5;
  float r_left = 5;

  for (int n = bodies; n<handx.size(); n++) {
    float a_x = handx.get(n);
    float a_y = handy.get(n);
    float b_x = handx.get(n - bodies);
    float b_y = handy.get(n - bodies);
    float dist = sqrt(sq(a_x-b_x)+sq(a_y-b_y));
    if (dist<5) {r = r+5;} else {r = 1;}
    noStroke();
    fill(r%100, 100, 100);
    ellipse(a_x,a_y,r,r);
    float a_x_left = handx_left.get(n);
    float a_y_left = handy_left.get(n);
    float b_x_left = handx_left.get(n - bodies);
    float b_y_left = handy_left.get(n - bodies);
    float dist_left = sqrt(sq(a_x_left-b_x_left)+sq(a_y_left-b_y_left));
    if (dist_left<5) {r_left = r_left+5;} else {r_left = 1;}
    noStroke();
    fill(r_left%100, 100, 100);
    ellipse(a_x_left,a_y_left,r_left,r_left);
  }
}

void drawZigzag(int bodies) {
  for (int n = bodies; n<handx.size(); n++) {
    float a_x = handx.get(n);
    float a_y = handy.get(n);
    float b_x = handx.get(n-bodies);
    float b_y = handy.get(n-bodies);
    float a_x_left = handx_left.get(n);
    float a_y_left = handy_left.get(n);
    float b_x_left = handx_left.get(n-bodies);
    float b_y_left = handy_left.get(n-bodies);
    float spread = sqrt(sq(a_x-a_x_left)+sq(a_y-a_y_left));
    stroke((spread/12)%100, 100, 100, 40);
    strokeWeight(4);
    line(a_x,a_y,a_x_left,a_y_left);
    line(b_x,b_y,b_x_left,b_y_left);
  }
}

void drawAvg(int bodies){
  for (int n = 1; n<handx.size(); n++) {
    float a_x = handx.get(n);
    float a_y = handy.get(n);
    float a_x_left = handx_left.get(n);
    float a_y_left = handy_left.get(n);
    float mid_x = (a_x+a_x_left)/(2);
    float mid_y = (a_y+a_y_left)/(2);
    noStroke();
    fill((a_x*a_y_left/5000)%100,100,100);
    ellipse(mid_x,mid_y,50*bodies,50*bodies);
  }
}