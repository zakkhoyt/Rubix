//
//  VWWCubeModel2x2Tests.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "VWWCubeModel2x2Tests.h"
#import "VWWCubeModel2x2.h"


@interface VWWCubeModel2x2Tests ()
@property (nonatomic, retain) VWWCubeModel2x2* cube;
@end


@implementation VWWCubeModel2x2Tests

- (void)setUp{
    [self printMethod:(char*)__FUNCTION__];
    [super setUp];
    _cube = [[VWWCubeModel2x2 alloc]initWithSize:2];
}

- (void)tearDown{
    [self printMethod:(char*)__FUNCTION__];
    [_cube release];
    [super tearDown];
}


- (void)testCubeAllocation{
    [self printMethod:(char*)__FUNCTION__];
    NSLog(@"Beginning state");
    STAssertTrue([self examineCubeExpectSolved:self.cube expectSolved:YES], nil);
}

-(void)testCubeSorting{
    [self printMethod:(char*)__FUNCTION__];
    NSLog(@"Sorting squares by face and location");
    [self.cube sortSquaresByFaceAndLocation];
    [self.cube printCube];
}



@end
