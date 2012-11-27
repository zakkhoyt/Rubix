//
//  VWWCubeModel5x5.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/27/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel.h"

typedef enum{
    VWWRotate5x5LeftOut = 0,
    VWWRotate5x5LeftOutPrime,
    VWWRotate5x5LeftIn,
    VWWRotate5x5LeftInPrime,
    VWWRotate5x5RightOut,
    VWWRotate5x5RightOutPrime,
    VWWRotate5x5RightIn,
    VWWRotate5x5RightInPrime,
    VWWRotate5x5TopOut,
    VWWRotate5x5TopOutPrime,
    VWWRotate5x5TopIn,
    VWWRotate5x5TopInPrime,
    VWWRotate5x5BottomOut,
    VWWRotate5x5BottomOutPrime,
    VWWRotate5x5BottomIn,
    VWWRotate5x5BottomInPrime,
    VWWRotate5x5FrontOut,
    VWWRotate5x5FrontOutPrime,
    VWWRotate5x5FrontIn,
    VWWRotate5x5FrontInPrime,
    VWWRotate5x5BackOut,
    VWWRotate5x5BackOutPrime,
    VWWRotate5x5BackIn,
    VWWRotate5x5BackInPrime,
} VWWRotate5x5;
@interface VWWCubeModel5x5 : VWWCubeModel
-(void)rotateSlice:(VWWRotate5x5)rotate;
@end
