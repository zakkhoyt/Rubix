//
//  VWWCubeModel3x3.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel.h"

typedef enum{
    VWWRotationFront = 0,
    VWWRotationFrontPrime,
    VWWRotationRight,
    VWWRotationRightPrime,
    VWWRotationBack,
    VWWRotationBackPrime,
    VWWRotationLeft,
    VWWRotationLeftPrime,
    VWWRotationTop,
    VWWRotationTopPrime,
} VWWRotation;


@interface VWWCubeModel3x3 : VWWCubeModel
// Perform a rotation
-(void)rotateSlice:(VWWRotation)rotate;
@end
