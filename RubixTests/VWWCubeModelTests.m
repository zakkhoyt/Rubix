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

-(void)testCubeSorting{
    [self printMethod:(char*)__FUNCTION__];
    NSLog(@"Sorting squares by face and location");
    [_cube sortSquaresByFaceAndLocation];
    [_cube printCube];
}

//- (void)testCubeRotations{
//    [self printMethod:(char*)__FUNCTION__];
//    
//    [self printSeparator:@"Beginning state"];
//    STAssertTrue([self examineCubeExpectSolved:YES], nil);
//    [_cube printCube];
//}



//// ********************************************* Test below here are for testing
//// ********************************************* methods that are now private
//- (void)testColorSplit{
//    [self printMethod:(char*)__FUNCTION__];
//    NSMutableArray* blue = nil;
//    NSMutableArray* green = nil;
//    NSMutableArray* orange = nil;
//    NSMutableArray* red = nil;
//    NSMutableArray* white = nil;
//    NSMutableArray* yellow = nil;
//    
//    [_cube breakSquaresIntoColorArraysBlue:&blue
//                                     green:&green
//                                    orange:&orange
//                                       red:&red
//                                     white:&white
//                                    yellow:&yellow];
//    
//    NSLog(@"blue=%@", blue);
//    NSLog(@"green=%@", green);
//    NSLog(@"orange=%@", orange);
//    NSLog(@"red=%@", red);
//    NSLog(@"white=%@", white);
//    NSLog(@"yellow=%@", yellow);
//}
//
//- (void)testFaceSplit{
//    [self printMethod:(char*)__FUNCTION__];
//    NSMutableArray* blue = nil;
//    NSMutableArray* green = nil;
//    NSMutableArray* orange = nil;
//    NSMutableArray* red = nil;
//    NSMutableArray* white = nil;
//    NSMutableArray* yellow = nil;
//    
//    [_cube breakSquaresIntoFaceArraysFront:&blue
//                                    right:&green
//                                   back:&orange
//                                      left:&red
//                                    top:&white
//                                   bottom:&yellow];
//    
//    NSLog(@"blue=%@", blue);
//    NSLog(@"green=%@", green);
//    NSLog(@"orange=%@", orange);
//    NSLog(@"red=%@", red);
//    NSLog(@"white=%@", white);
//    NSLog(@"yellow=%@", yellow);
//}
//


@end




