//
//  VWWCubeModelTests.h
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "VWWCubeModel.h"

@interface VWWCubeModelTests : SenTestCase

@end

@interface VWWCubeModelTests (helpers)
-(void)printSeparator;
-(void)printSeparator:(NSString*)message;
-(void)printMethod:(char*)method;
-(bool)examineCubeExpectSolved:(VWWCubeModel*)cube expectSolved:(bool)expectSolved;
@end
