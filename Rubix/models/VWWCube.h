//
//  VWWCube.h
//  rubix
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

// Faces (sides) of the cube
typedef enum{
    kVWWFaceFront = 0,
    kVWWFaceBack,
    kVWWFaceTop,
    kVWWFaceBottom,
    kVWWFaceLeft,
    kVWWFaceRight,
    
} VWWFace;

// Direction to rotate a square
typedef enum{
    VWWDirectionClockwise = 0,
    VWWDirectionAnticlockwise,
} VWWDirection;

// Specifies how to rotate a section of the cube
typedef enum{
    kVWWRotationTopRowLeft = 0,
    kVWWRotationTopRowRight,
    kVWWRotationMiddleRowLeft,
    kVWWRotationMiddelRowRight,
    kVWWRotationBottomRowLeft,
    kVWWRotationBottomRowRight,
    kVWWRotationLeftColumnUp,
    kVWWRotationLeftColumnDown,
    kVWWRotationMiddleColumnUp,
    kVWWRotationMiddleColumnDown,
    kVWWRotationRightColumnUp,
    kVWWRotationRigthColumnDown,
    kVWWRotationFrontSquareClockwise,
    kVWWRotationFrontSquareAntiClockwise,
    kVWWRotationMiddleSquareClockwise,
    kVWWRotationMiddleSquareAntiClockwise,
    kVWWRotationBackSquareClockwise,
    kVWWRotationBackSquareAntiClockwise,
} VWWRotation;

// Indivicual square colors
typedef enum{
    kVWWColorBlue = 0x00,
    kVWWColorGreen,
    kVWWColorOrange,
    kVWWColorRed,
    kVWWColorWhite,
    kVWWColorYellow,
} VWWColor;


@interface VWWCube : NSObject

// Checks if each side of the cube is a solid color. Doesn't matter which
-(bool)isSolved;

// Grab the current state of the cube
-(void)getCubeDataTop:(VWWColor*)top
               bottom:(VWWColor*)bottom
                front:(VWWColor*)front
                 back:(VWWColor*)back
                 left:(VWWColor*)left
                right:(VWWColor*)right;
// Perform a rotation
-(void)modifyFace:(VWWFace)face
     withRotation:(VWWRotation)rotation;




// ********************* Methods below here will be made private eventually
// ********************* They are public to allow for easy unit testing as
// ********************* the class is written.

// Print the cube data to the console
-(void)printCube;

// These will eventually be private, and accessed with modifyFace:withRotation:
// They are currently in the header to allow for quick unit testing.
-(void)rotateTopRowLeft;
-(void)rotateTopRowRight;
-(void)rotateMiddleRowLeft;
-(void)rotateMiddleRowRight;
-(void)rotateBottomRowLeft;
-(void)rotateBottomRowRight;
-(void)rotateLeftColumnUp;
-(void)rotateLeftColumnDown;
-(void)rotateMiddleColumnUp;
-(void)rotateMiddleColumnDown;
-(void)rotateRightColumnUp;
-(void)rotateRightColumnDown;
-(void)rotateFrontSquareClockwise;
-(void)rotateFrontSquareAntiClockwise;
-(void)rotateMiddleSquareClockwise;
-(void)rotateMiddleSquareAntiClockwise;
-(void)rotateBackSquareClockwise;
-(void)rotateBackSquareAntiClockwise;
@end
