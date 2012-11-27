//
//  VWWCubeModel3x3.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel.h"

typedef enum{
    VWWRotate3x3Front = 0,
    VWWRotate3x3FrontPrime,
    VWWRotate3x3Right,
    VWWRotate3x3RightPrime,
    VWWRotate3x3Back,
    VWWRotate3x3BackPrime,
    VWWRotate3x3Left,
    VWWRotate3x3LeftPrime,
    VWWRotate3x3Top,
    VWWRotate3x3TopPrime,
} VWWRotate3x3;


@interface VWWCubeModel3x3 : VWWCubeModel
-(void)rotateSlice:(VWWRotate3x3)rotate;
@end
