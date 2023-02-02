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
FloatList handx_left;
FloatList handy_left;

KinectPV2 kinect;

void setup() {

  size(1920, 1080, P3D);
  //fullScreen(P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

// Enable 3d  with (x,y,z) position
  kinect.enableSkeleton3DMap(true);

  kinect.init();
  
  handx = new FloatList();
  handy = new FloatList();
  handx_left = new FloatList();
  handy_left = new FloatList();
  
}

void draw() {
  background(0);



// If you want to see the RGB image from HD Camera
  //image(kinect.getColorImage(), 0, 0, width, height);

// Get the depth image data
  //rawDepth = kinect.getDepthMaskImage();

// Get the 2D array data points from the Skeleton Color Map  
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

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
      
      if (handx.size() > 1500){
        handx.clear();
        handy.clear();
        handx_left.clear();
        handy_left.clear();
      }

    } 
   
  }
  
  for (int n = 5; n<handx.size(); n++) { //HALM: draw lines
        colorMode(HSB, 100);
        int bodies = skeletonArray.size();
        float a_x = handx.get(n);
        float a_y = handy.get(n);
        float b_x = handx.get(n-bodies);
        float b_y = handy.get(n-bodies);
        float dist = sqrt(sq(a_x-b_x)+sq(a_y-b_y));
        stroke(dist, 100, 100);
        strokeWeight(10);
        line(b_x,b_y,a_x,a_y);
        float a_x_left = handx_left.get(n);
        float a_y_left = handy_left.get(n);
        float b_x_left = handx_left.get(n-bodies);
        float b_y_left = handy_left.get(n-bodies);
        float dist_left = sqrt(sq(a_x_left-b_x_left)+sq(a_y_left-b_y_left));
        stroke(dist_left, 100, 100);
        strokeWeight(10);
        line(b_x_left,b_y_left,a_x_left,a_y_left);
  }