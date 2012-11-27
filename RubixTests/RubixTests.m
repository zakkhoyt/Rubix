//
//  RubixTests.m
//  RubixTests
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "RubixTests.h"
#import "VWWCubeModel.h"
#import <SenTestingKit/SenTestingKit.h>


@interface RubixTests (){
    VWWColor _front[3][3];
    VWWColor _back[3][3];
    VWWColor _top[3][3];
    VWWColor _bottom[3][3];
    VWWColor _left[3][3];
    VWWColor _right[3][3];
}
@property (nonatomic, retain) VWWCube* cube;
@end

@implementation RubixTests (helpers)
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

@implementation RubixTests


- (void)setUp{
    [self printMethod:(char*)__FUNCTION__];
    [super setUp];
    _cube = [[VWWCube alloc]init];
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
    
    [self printSeparator:@"TEST ROTATION OF ROWS"];
    [self printSeparator:@"Rotating top row left"];
    [self.cube rotateTopRowLeft];
    STAssertTrue([self examineCubeExpectSolved:NO], nil);
    [self printSeparator:@"Rotating top row right (undo)"];
    [self.cube rotateTopRowRight];
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    
    [self printSeparator:@"Rotating middle row left"];
    [self.cube rotateMiddleRowLeft];
    STAssertTrue([self examineCubeExpectSolved:NO], nil);
    [self printSeparator:@"Rotating middle row right (undo)"];
    [self.cube rotateMiddleRowRight];
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    
    [self printSeparator:@"Rotating bottom row left"];
    [self.cube rotateBottomRowLeft];
    STAssertTrue([self examineCubeExpectSolved:NO], nil);
    [self printSeparator:@"Rotating bottom row right (undo)"];
    [self.cube rotateBottomRowRight];
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    
    [self printSeparator:@"TEST ROTATION OF COLUMNS"];
    [self printSeparator:@"Rotating left column up"];
    [self.cube rotateLeftColumnUp];
    STAssertTrue([self examineCubeExpectSolved:NO], nil);
    [self printSeparator:@"Rotating left column down (undo)"];
    [self.cube rotateLeftColumnDown];
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    
    [self printSeparator:@"Rotating middle column up"];
    [self.cube rotateMiddleColumnUp];
    STAssertTrue([self examineCubeExpectSolved:NO], nil);
    [self printSeparator:@"Rotating middle column down (undo)"];
    [self.cube rotateMiddleColumnDown];
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    
    [self printSeparator:@"Rotating right column up"];
    [self.cube rotateRightColumnUp];
    STAssertTrue([self examineCubeExpectSolved:NO], nil);
    [self printSeparator:@"Rotating right column down (undo)"];
    [self.cube rotateRightColumnDown];
    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    
//    
//    [self printSeparator:@"TEST ROTATION OF SQUARES"];
//    [self printSeparator:@"Rotating front square anti-clockwise"];
//    [self.cube rotateFrontSquareAntiClockwise];
//    STAssertTrue([self examineCubeExpectSolved:NO], nil);
//    [self printSeparator:@"Rotating front square clockwise (undo)"];
//    [self.cube rotateFrontSquareClockwise];
//    STAssertTrue([self examineCubeExpectSolved:YES], nil);
//    
//    [self printSeparator:@"Rotating middle square anti-clockwise"];
//    [self.cube rotateMiddleSquareAntiClockwise];
//    STAssertTrue([self examineCubeExpectSolved:NO], nil);
//    [self printSeparator:@"Rotating middle square clockwise (undo)"];
//    [self.cube rotateMiddleSquareClockwise];
//    STAssertTrue([self examineCubeExpectSolved:YES], nil);
//    
//    [self printSeparator:@"Rotating back square anti-clockwise"];
//    [self.cube rotateBackSquareAntiClockwise];
//    STAssertTrue([self examineCubeExpectSolved:NO], nil);
//    [self printSeparator:@"Rotating back square clockwise (undo)"];
//    [self.cube rotateBackSquareClockwise];
//    STAssertTrue([self examineCubeExpectSolved:YES], nil);
    
}


@end
