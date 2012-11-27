//
//  VWWCubeModel4x4Tests.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "VWWCubeModel4x4Tests.h"
#import "VWWCubeModel4x4.h"


@interface VWWCubeModel4x4Tests ()
@property (nonatomic, retain) VWWCubeModel4x4* cube;
@end


@implementation VWWCubeModel4x4Tests

- (void)setUp{
    [self printMethod:(char*)__FUNCTION__];
    [super setUp];
    _cube = [[VWWCubeModel4x4 alloc]initWithSize:4];
    
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
