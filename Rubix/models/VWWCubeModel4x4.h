//
//  VWWCubeModel4x4.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/27/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel.h"
typedef enum{
    VWWRotate4x4LeftOut = 0,
    VWWRotate4x4LeftOutPrime,
    VWWRotate4x4LeftIn,
    VWWRotate4x4LeftInPrime,
    VWWRotate4x4RightOut,
    VWWRotate4x4RightOutPrime,
    VWWRotate4x4RightIn,
    VWWRotate4x4RightInPrime,
    VWWRotate4x4TopOut,
    VWWRotate4x4TopOutPrime,
    VWWRotate4x4TopIn,
    VWWRotate4x4TopInPrime,
    VWWRotate4x4BottomOut,
    VWWRotate4x4BottomOutPrime,
    VWWRotate4x4BottomIn,
    VWWRotate4x4BottomInPrime,
    VWWRotate4x4FrontOut,
    VWWRotate4x4FrontOutPrime,
    VWWRotate4x4FrontIn,
    VWWRotate4x4FrontInPrime,
    VWWRotate4x4BackOut,
    VWWRotate4x4BackOutPrime,
    VWWRotate4x4BackIn,
    VWWRotate4x4BackInPrime,
} VWWRotate4x4;
@interface VWWCubeModel4x4 : VWWCubeModel
-(void)rotateSlice:(VWWRotate4x4)rotate;
@end
