Originally created in 2018

# Overview of Sketches

## kinectWrite2a_dots
pulls hand locations at regular intervals and draws dots at those locations

## kinectWrite2b_lines
pulls hand locations at regular intervals and connects those locations with lines

## kinectWrite3a_speed
similar to kinectWrite2b_lines but varies stroke weight based on distance between points ("speed")

## kinectWrite3b_speed2
similar to kinectWrite2b_lines but varies stroke color based on distance between points ("speed")

## kinectWrite3c_spread
pulls hand locations at regular intervals, draws dots at location of right hand with varying size and color based on distance between right and left hands

## kinectWrite4_depth
varies stroke color and weight based on distance from sensor

## kinectWrite5_time
pulls hand location at regular intervals and draws dots at those locations; the longer a hand remains in the same position, the larger the dot grows (and cycles color)

## kinectWrite_demo
kinectWrite_demo combines all other sketches and cycles through them

# Source Material
* skeleton_basis and skeleton_color_3D from antoine1000: https://github.com/antoine1000/kinect-skeleton
* openKinect library from Thomas Lengeling https://github.com/ThomasLengeling/KinectPV2 (see also https://github.com/shiffman/OpenKinect-for-Processing)
