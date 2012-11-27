//
//  VWWCubeModel5x5Tests.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "VWWCubeModel5x5Tests.h"
#import "VWWCubeModel5x5.h"


@interface VWWCubeModel5x5Tests ()
@property (nonatomic, retain) VWWCubeModel5x5* cube;
@end


@implementation VWWCubeModel5x5Tests

- (void)setUp{
    [self printMethod:(char*)__FUNCTION__];
    [super setUp];
    _cube = [[VWWCubeModel5x5 alloc]initWithSize:5];
    
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
