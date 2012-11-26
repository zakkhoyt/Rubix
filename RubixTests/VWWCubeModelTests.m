//
//  VWWCubeModelTests.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModelTests.h"
#import "VWWCubeModel.h"
#import <SenTestingKit/SenTestingKit.h>


@interface VWWCubeModelTests ()
@property (nonatomic, retain) VWWCubeModel* cube;
@end



@implementation VWWCubeModelTests (helpers)
-(void)printSeparator{
    NSLog(@"*********************************************************************************");
}
-(void)printSeparator:(NSString*)message{
    NSLog(@"***************************** %@ ********************************", message);
}
-(void)printMethod:(char*)method{
    NSLog(@"***************** %s ********************************************", method);
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



@implementation VWWCubeModelTests

- (void)setUp{
    [self printMethod:(char*)__FUNCTION__];
    [super setUp];
    _cube = [[VWWCubeModel alloc]initWithSize:3];
    
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





- (void)testCubeRotations{
    [self printMethod:(char*)__FUNCTION__];
    
    [self printSeparator:@"Beginning state"];
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    [_cube printCube];
    
}

@end




