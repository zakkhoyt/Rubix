//
//  VWWCubeModel2x2.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/27/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel.h"

typedef enum{
    VWWRotate2x2Front = 0,
    VWWRotate2x2FrontPrime,
    VWWRotate2x2Right,
    VWWRotate2x2RightPrime,
    VWWRotate2x2Back,
    VWWRotate2x2BackPrime,
    VWWRotate2x2Left,
    VWWRotate2x2LeftPrime,
    VWWRotate2x2Top,
    VWWRotate2x2TopPrime,
} VWWRotate2x2;

@interface VWWCubeModel2x2 : VWWCubeModel
-(void)rotateSlice:(VWWRotate2x2)rotate;
@end
