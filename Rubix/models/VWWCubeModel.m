//
//  VWWCubeModel.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel.h"
#define VWW_DEFAULT_CUBE_SIZE 3

@interface VWWCubeModel ()
@property (nonatomic) NSUInteger cubeSize;
@property (nonatomic) NSUInteger squaresPerColor;
@property (nonatomic, retain) NSMutableArray* redSquares;
@property (nonatomic, retain) NSMutableArray* blueSquares;
@property (nonatomic, retain) NSMutableArray* greenSquares;
@property (nonatomic, retain) NSMutableArray* yellowSquares;
@property (nonatomic, retain) NSMutableArray* orangeSquares;
@property (nonatomic, retain) NSMutableArray* whiteSquares;
@end

@implementation VWWCubeModel

-(id)init{
    return [self initWithSize:VWW_DEFAULT_CUBE_SIZE];
}
// Allocate a new cube with <size> cubes per side;
-(id)initWithSize:(NSUInteger)size{
    self = [super init];
    if(self){
        self.cubeSize = size;
        self.squaresPerColor = self.cubeSize * self.cubeSize;
        [self initializeClass];
    }
    return self;
}


-(void)initializeClass{
    self.redSquares = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    self.greenSquares = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    self.blueSquares = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    self.yellowSquares = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    self.orangeSquares = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    self.whiteSquares = [[NSMutableArray alloc]initWithCapacity:self.squaresPerColor];
    
    
    for(NSUInteger index = 0; index < self.squaresPerColor; index++){
        VWWSquareModel* square;
        square = [[VWWSquareModel alloc]initWithColor:kVWWColorBlue atLocation:index onFace:kVWWFaceBack];
        [self.blueSquares addObject:square];
        [square release];
        
        square = [[VWWSquareModel alloc]initWithColor:kVWWColorGreen atLocation:index onFace:kVWWFaceLeft];
        [self.greenSquares addObject:square];
        [square release];
    }
    
    

    NSLog(@"%@", self.blueSquares);
        NSLog(@"%@", self.greenSquares);
    
    
}

// Checks if each side of the cube is a solid color. Doesn't matter which
-(bool)isSolved{
    return NO;
}


// Mess the cube up. Give it some random twists;
-(void)jumbleWithIntensity:(NSUInteger)intensity{
    
}

// ********************* Methods below here will be made private eventually
// ********************* They are public to allow for easy unit testing as
// ********************* the class is written.

// Print the cube data to the console
-(void)printCube{
//    for(NSUInteger index = 0; index < pow(self.size, self.size); index++){
////        VWWSquareModel* blueSquare = [self.blueSquares objectAtIndex:index];
////        VWWSquareModel* greenSquare = [self.greenSquares objectAtIndex:index];
////        NSLog(@"");
//    }
}

// Perform a rotation
-(void)rotateSlice{
    
}


@end
