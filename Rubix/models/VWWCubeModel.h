//
//  VWWCubeModel.h
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  When a new (this) object is allocated it will be in the solved state.
//
//  There are methods to manipulate the cube. There are pow(size, 3)*2 ways to rotate a cube,
//  Picture the front of a size 3 cube (3x3). You can
//  make the following rotations:
//  Rotate column 1 (left/right)
//  Rotate column 2 (left/right)
//  Rotate column 3 (left/right)
//  Rotate row 1 (up/down)
//  Rotate row 2 (up/down)
//  Rotate row 3 (up/down)
//  You can also rotate that entire front face (clockwise/anticlockwise
//  Next, the back face  (clockwise/anticlockwise
//  Also the middle face (clockwise/anticlockwise
//
//  Of course we can have cubes of different sizes as well, but the formula stays the same. 


#import <Foundation/Foundation.h>
#import "VWWSquareModel.h"
@interface VWWCubeModel : NSObject

// Direction to rotate a square
typedef enum{
    VWWDirectionClockwise = 0,
    VWWDirectionAnticlockwise,
} VWWDirection;


// Allocate a new cube with <size> cubes per side;
-(id)initWithSize:(NSUInteger)size;

// Checks if each side of the cube is a solid color. Doesn't matter which
-(bool)isSolved;


// Perform a rotation
-(void)rotateSlice;

// Mess the cube up. Give it some random twists;
-(void)jumbleWithIntensity:(NSUInteger)intensity;

// Print the cube data to the console
-(void)printCube;


@end
