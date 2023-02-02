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

//turns on sensors
  kinect.enableSkeletonColorMap(true);
//  kinect.enableColorImg(true);

// Enable 3d  with (x,y,z) position
//  kinect.enableSkeleton3DMap(true);

  kinect.init();
  
//HALM - lists for drawing
  handx = new FloatList();
  handy = new FloatList();
  handx_left = new FloatList();
  handy_left = new FloatList();
  
}

void draw() {
  background(0);

// Get the 2D array data points from the Skeleton Color Map  
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

// Get the Skeleton data joints (X & Y only)

  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
   //   color col  = skeleton.getIndexColor();
   
      //HALM - add position of right hand to list
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
 
  //HALM - draw line based on all hand positions
  for (int n = 5; n<handx.size(); n++) {
        int bodies = skeletonArray.size();
        stroke(255,100);
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