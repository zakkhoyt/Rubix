//
//  VWWMultipleCubes.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/21/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWScene.h"
#define M_TAU (2*M_PI)

@interface VWWMultipleCubes : VWWScene
@property GLKVector3 position;
@property (nonatomic) GLKVector3 rotation, scale, rps;
@end
