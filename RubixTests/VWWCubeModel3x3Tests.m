//
//  VWWCubeModel3x3Tests.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "VWWCubeModel3x3Tests.h"
#import "VWWCubeModel3x3.h"


@interface VWWCubeModel3x3Tests ()
@property (nonatomic, retain) VWWCubeModel3x3* cube;
@end

@implementation VWWCubeModel3x3Tests (helpers)
-(void)printSeparator{
    NSLog(@"********************************");
}
-(void)printSeparator:(NSString*)message{
    NSLog(@"********* %@ **********", message);
}
-(void)printMethod:(char*)method{
    NSLog(@"********* %s **********", method);
}

-(bool)examineCubeExpectSolved:(bool)expectSolved{
    if([self.cube isSolved] == expectSolved){
        NSLog(@"Cube state okay.");
        return YES;
    }
    
    NSLog(@"ERROR! Cube is not solved");
    [self.cube printCube];
    return NO;
}
@end



@implementation VWWCubeModel3x3Tests

- (void)setUp{
    [self printMethod:(char*)__FUNCTION__];
    [super setUp];
    _cube = [[VWWCubeModel3x3 alloc]initWithSize:3];
    
}

- (void)tearDown{
    [self printMethod:(char*)__FUNCTION__];
    [_cube release];
    [super tearDown];
}


- (void)testCubeAllocation{
    [self printMethod:(char*)__FUNCTION__];
    NSLog(@"Beginning state");
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
}

-(void)testCubeSorting{
    [self printMethod:(char*)__FUNCTION__];
    NSLog(@"Sorting squares by face and location");
    [self.cube sortSquaresByFaceAndLocation];
    [self.cube printCube];
}



@end
