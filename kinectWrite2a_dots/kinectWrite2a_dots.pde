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

      
      //HALM
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
           colorMode(HSB, 100);

     for (int n = 5; n<handx.size(); n++) {
        int bodies = skeletonArray.size();
        float a_x = handx.get(n);
        float a_y = handy.get(n);
        float b_x = handx.get(n - bodies);
        float b_y = handy.get(n - bodies);
        float dist = sqrt(sq(a_x-b_x)+sq(a_y-b_y));
        stroke(dist, 100, 100);
        fill(dist, 100, 100);
        ellipse(a_x,a_y,dist/10+2,dist/10+2);
        
      //}
     // for (int n = 1; n<handx_left.size(); n++) {
     //   int bodies = skeletonArray.size();
        float a_x_left = handx_left.get(n);
        float a_y_left = handy_left.get(n);
        float b_x_left = handx_left.get(n - bodies);
        float b_y_left = handy_left.get(n - bodies);
        float dist_left = sqrt(sq(a_x_left-b_x_left)+sq(a_y_left-b_y_left));
        stroke(dist_left, 100, 100);
        fill(dist_left, 100, 100);
        ellipse(a_x_left,a_y_left,dist_left/10+2,dist_left/10+2);
      }
  }


// Get the 3D data points from the 3D skeleton (access to Z point)
  ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();

  for (int i = 0; i < skeleton3DArray.size(); i++) {
    KSkeleton skeleton3D = (KSkeleton) skeleton3DArray.get(i);
    if (skeleton3D.isTracked()) {
      KJoint[] joints3D = skeleton3D.getJoints();

      float zzz = getZJoint(joints3D, HAND_RIGHT);

// Print the X, Y, Z positions of Skeleton 3D
      float zpos = joints3D[HAND_RIGHT].getZ();
      float convertZ = map(zpos, 0.5, 4, 0, 100); // value to be remapped, original range min, original range max, new min, new max


    }
  }

  fill(255, 0, 0);
  textSize(10);
  text(frameRate, 50, 50);
}


  float[] getSkeletonZ(KJoint[] joints3D) {
    int joints_number = 25;
    float[] z_values = new float[joints_number];
// For every joints, get the z value, store it in an array 
     for(int i = 0; i < joints_number; i++) {
        z_values[i] = joints3D[i].getZ();
      }
      return z_values;
  }