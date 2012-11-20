//
//  VWWCube.m
//  rubix
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  Visualize the cube face like this represented by [x][y]
//  [0][0], [0][1], [0][2]
//  [1][0], [1][1], [1][2]
//  [2][0], [2][1], [2][2]

#import "VWWCube.h"

@interface VWWCube () {
    VWWColor _front[3][3];
    VWWColor _back[3][3];
    VWWColor _top[3][3];
    VWWColor _bottom[3][3];
    VWWColor _left[3][3];
    VWWColor _right[3][3];
}
@property (nonatomic) NSUInteger cubeSize;
@end

@implementation VWWCube

-(id)init{
    self = [super init];
    if(self){
        [self initializeCube];
    }
    return self;
}


-(void)initializeCube{
    self.cubeSize = 3;
    for (int x=0; x<3; x++){
        for (int y=0; y<3; y++){
            _top[x][y]=kVWWColorBlue;
            _bottom[x][y] = kVWWColorGreen;
            _front[x][y] = kVWWColorOrange;
            _back[x][y] = kVWWColorRed;
            _left[x][y] = kVWWColorWhite;
            _right[x][y] = kVWWColorYellow;
        }
    }
}


-(NSString*)stringForColor:(VWWColor)color{
    switch(color){
        case kVWWColorBlue:
            return @"B";
        case kVWWColorOrange:
            return @"O";
        case kVWWColorGreen:
            return @"G";
        case kVWWColorRed:
            return @"R";
        case kVWWColorWhite:
            return @"W";
        case kVWWColorYellow:
            return @"Y";
        default:
            return @"!";
    }
}

-(void)printFace:(VWWFace)face{
    switch(face){
        case kVWWFaceTop:
            NSLog(@"top face:");
            NSLog(@"%@%@%@", [self stringForColor:_top[0][0]], [self stringForColor:_top[1][0]], [self stringForColor:_top[2][0]]);
            NSLog(@"%@%@%@", [self stringForColor:_top[0][1]], [self stringForColor:_top[1][1]], [self stringForColor:_top[2][1]]);
            NSLog(@"%@%@%@", [self stringForColor:_top[0][2]], [self stringForColor:_top[1][2]], [self stringForColor:_top[2][2]]);
            break;
        case kVWWFaceBottom:
            NSLog(@"bottom face:");
            NSLog(@"%@%@%@", [self stringForColor:_bottom[0][0]], [self stringForColor:_bottom[1][0]], [self stringForColor:_bottom[2][0]]);
            NSLog(@"%@%@%@", [self stringForColor:_bottom[0][1]], [self stringForColor:_bottom[1][1]], [self stringForColor:_bottom[2][1]]);
            NSLog(@"%@%@%@", [self stringForColor:_bottom[0][2]], [self stringForColor:_bottom[1][2]], [self stringForColor:_bottom[2][2]]);
            break;
        case kVWWFaceFront:
            NSLog(@"front face:");
            NSLog(@"%@%@%@", [self stringForColor:_front[0][0]], [self stringForColor:_front[1][0]], [self stringForColor:_front[2][0]]);
            NSLog(@"%@%@%@", [self stringForColor:_front[0][1]], [self stringForColor:_front[1][1]], [self stringForColor:_front[2][1]]);
            NSLog(@"%@%@%@", [self stringForColor:_front[0][2]], [self stringForColor:_front[1][2]], [self stringForColor:_front[2][2]]);
            
            break;
        case kVWWFaceBack:
            NSLog(@"back face:");
            NSLog(@"%@%@%@", [self stringForColor:_back[0][0]], [self stringForColor:_back[1][0]], [self stringForColor:_back[2][0]]);
            NSLog(@"%@%@%@", [self stringForColor:_back[0][1]], [self stringForColor:_back[1][1]], [self stringForColor:_back[2][1]]);
            NSLog(@"%@%@%@", [self stringForColor:_back[0][2]], [self stringForColor:_back[1][2]], [self stringForColor:_back[2][2]]);
            break;
        case kVWWFaceLeft:
            NSLog(@"left face:");
            NSLog(@"%@%@%@", [self stringForColor:_left[0][0]], [self stringForColor:_left[1][0]], [self stringForColor:_left[2][0]]);
            NSLog(@"%@%@%@", [self stringForColor:_left[0][1]], [self stringForColor:_left[1][1]], [self stringForColor:_left[2][1]]);
            NSLog(@"%@%@%@", [self stringForColor:_left[0][2]], [self stringForColor:_left[1][2]], [self stringForColor:_left[2][2]]);
            break;
        case kVWWFaceRight:
            NSLog(@"right face:");
            NSLog(@"%@%@%@", [self stringForColor:_right[0][0]], [self stringForColor:_right[1][0]], [self stringForColor:_right[2][0]]);
            NSLog(@"%@%@%@", [self stringForColor:_right[0][1]], [self stringForColor:_right[1][1]], [self stringForColor:_right[2][1]]);
            NSLog(@"%@%@%@", [self stringForColor:_right[0][2]], [self stringForColor:_right[1][2]], [self stringForColor:_right[2][2]]);
            break;
        default:
            break;
    }
}

// Check if each face of the cube is a unique solid color.
-(bool)isSolved{
    VWWColor topColor = kVWWColorWhite;
    VWWColor bottomColor = kVWWColorWhite;
    VWWColor frontColor = kVWWColorWhite;
    VWWColor backColor = kVWWColorWhite;
    VWWColor leftColor = kVWWColorWhite;
    VWWColor rightColor = kVWWColorWhite;
    for(NSUInteger x=0; x<self.cubeSize; x++){
        for(NSUInteger y=0; y<self.cubeSize; y++){
            if(x == 0 && y == 0){
                topColor = _top[x][y];
                bottomColor = _bottom[x][y];
                frontColor = _front[x][y];
                backColor = _back[x][y];
                leftColor = _left[x][y];
                rightColor = _right[x][y];
            }
            if(_top[x][y] != topColor){
                return NO;
            }
            if(_bottom[x][y] != bottomColor){
                return NO;
            }
            if(_front[x][y] != frontColor){
                return NO;
            }
            if(_back[x][y] != backColor){
                return NO;
            }
            if(_left[x][y] != leftColor){
                return NO;
            }
            if(_right[x][y] != rightColor){
                return NO;
            }
        }
    }
    
    return YES;
}

-(void)getCubeDataTop:(VWWColor*)top
               bottom:(VWWColor*)bottom
                front:(VWWColor*)front
                 back:(VWWColor*)back
                 left:(VWWColor*)left
                right:(VWWColor*)right{
    
    memcpy(top, _top, 36);
    memcpy(bottom, _bottom, 36);
    memcpy(front, _front, 36);
    memcpy(back, _back, 36);
    memcpy(left, _left, 36);
    memcpy(right, _right, 36);
}

-(void)printCube{
    [self printFace:kVWWFaceTop];
    [self printFace:kVWWFaceBottom];
    [self printFace:kVWWFaceFront];
    [self printFace:kVWWFaceBack];
    [self printFace:kVWWFaceLeft];
    [self printFace:kVWWFaceRight];
}

-(void)modifyFace:(VWWFace)face withRotation:(VWWRotation)rotation{
    if(face == kVWWFaceTop){
        
    }
    else if(face == kVWWFaceBottom){
        
    }
    else if(face == kVWWFaceFront){
        
    }
    else if(face == kVWWFaceBack){
        
    }
    else if(face == kVWWFaceLeft){
        
    }
    else if(face == kVWWFaceRight){
        
    }
}



#pragma mark Private methods below here
// We will programmatically alter the arrays in the order listed in the comments
// before each method.


-(void)rotateLeftwardRow:(NSUInteger)r{
    VWWColor tempFront[3] = {kVWWColorWhite,
        kVWWColorWhite,
        kVWWColorWhite};
    tempFront[0] = _front[0][r];
    tempFront[1] = _front[1][r];
    tempFront[2] = _front[2][r];
    
    // front = right
    _front[0][r] = _right[0][r];
    _front[1][r] = _right[1][r];
    _front[2][r] = _right[2][r];
    
    // right = back
    _right[0][r] = _back[0][r];
    _right[1][r] = _back[1][r];
    _right[2][r] = _back[2][r];
    
    // back = left
    _back[0][r] = _left[0][r];
    _back[1][r] = _left[1][r];
    _back[2][r] = _left[2][r];
    
    // left = front
    _left[0][r] = tempFront[0];
    _left[1][r] = tempFront[1];
    _left[2][r] = tempFront[2];
}

-(void)rotateRightwardwardRow:(NSUInteger)r{
    VWWColor tempFront[3] = {0,0,0};
    tempFront[0] = _front[0][r];
    tempFront[1] = _front[1][r];
    tempFront[2] = _front[2][r];
    
    // front = left
    _front[0][r] = _left[0][r];
    _front[1][r] = _left[1][r];
    _front[2][r] = _left[2][r];
    
    // left = back
    _left[0][r] = _back[0][r];
    _left[1][r] = _back[1][r];
    _left[2][r] = _back[2][r];
    
    // back = right
    _back[0][r] = _right[0][r];
    _back[1][r] = _right[1][r];
    _back[2][r] = _right[2][r];
    
    // right = front
    _right[0][r] = tempFront[0];
    _right[1][r] = tempFront[1];
    _right[2][r] = tempFront[2];
}

// Affects sides front back left right top
-(void)rotateTopRowLeft{
    NSLog(@"Rotating top row left");
    [self rotateLeftwardRow:0];
    [self rotateSide:(VWWColor*)_top direction:VWWDirectionClockwise];
}
// Affects sides front back left right top
-(void)rotateTopRowRight{
    NSLog(@"Rotating top row right");
    [self rotateRightwardwardRow:0];
    // rotate top anticlockwise
    [self rotateSide:(VWWColor*)_top direction:VWWDirectionAnticlockwise];
}

// Affects sides front back left right
-(void)rotateMiddleRowLeft{
    NSLog(@"Rotating middle row left");
    [self rotateLeftwardRow:1];
}

// Affects sides front back left right
-(void)rotateMiddleRowRight{
    NSLog(@"Rotating middle row right");
    [self rotateRightwardwardRow:1];
}

// Affects sides front back left right bottom
-(void)rotateBottomRowLeft{
    NSLog(@"Rotating bottom row left");
    [self rotateLeftwardRow:2];
    [self rotateSide:(VWWColor*)_bottom direction:VWWDirectionAnticlockwise];
}
// Affects sides front back left right bottom
-(void)rotateBottomRowRight{
    NSLog(@"Rotating bottom row right");
    [self rotateRightwardwardRow:2];
    [self rotateSide:(VWWColor*)_bottom direction:VWWDirectionClockwise];
}


-(void)rotateUpwardColumn:(NSUInteger)c{
    VWWColor tempFront[3] = {kVWWColorWhite,
        kVWWColorWhite,
        kVWWColorWhite};
    tempFront[0] = _front[c][0];
    tempFront[1] = _front[c][1];
    tempFront[2] = _front[c][2];
    
    // front = bottom
    _front[c][0] = _bottom[c][0];
    _front[c][1] = _bottom[c][1];
    _front[c][2] = _bottom[c][2];
    
    // bottom = back
    _bottom[c][0] = _back[c][0];
    _bottom[c][1] = _back[c][1];
    _bottom[c][2] = _back[c][2];
    
    // back = top
    _back[c][0] = _top[c][0];
    _back[c][1] = _top[c][1];
    _back[c][2] = _top[c][2];
    
    // top = front
    _top[c][0] = tempFront[0];
    _top[c][1] = tempFront[1];
    _top[c][2] = tempFront[2];
}

-(void)rotateDownwardColumn:(NSUInteger)c{
    VWWColor tempFront[3] = {0,0,0};
    tempFront[0] = _front[c][0];
    tempFront[1] = _front[c][1];
    tempFront[2] = _front[c][2];
    
    // front = top
    _front[c][0] = _top[c][0];
    _front[c][1] = _top[c][1];
    _front[c][2] = _top[c][2];
    
    // top = back
    _top[c][0] = _back[c][0];
    _top[c][1] = _back[c][1];
    _top[c][2] = _back[c][2];
    
    // back = bottom
    _back[c][0] = _bottom[c][0];
    _back[c][1] = _bottom[c][1];
    _back[c][2] = _bottom[c][2];
    
    // bottom = front
    _bottom[c][0] = tempFront[0];
    _bottom[c][1] = tempFront[1];
    _bottom[c][2] = tempFront[2];
}

// Affects sides front back top bottom left
-(void)rotateLeftColumnUp{
    NSLog(@"Rotating left column up");
    [self rotateUpwardColumn:0];
    [self rotateSide:(VWWColor*)_left direction:VWWDirectionAnticlockwise];    
}
// Affects sides front back top bottom left
-(void)rotateLeftColumnDown{
    NSLog(@"Rotating left column up");
    [self rotateDownwardColumn:0];
    [self rotateSide:(VWWColor*)_left direction:VWWDirectionClockwise];
}
// Affects sides front back top bottom
-(void)rotateMiddleColumnUp{
    NSLog(@"Rotating middle column up");
    [self rotateUpwardColumn:1];
}
// Affects sides front back top bottom
-(void)rotateMiddleColumnDown{
    NSLog(@"Rotating left column down");
    [self rotateDownwardColumn:1];
}
// Affects sides front back top bottom right
-(void)rotateRightColumnUp{
    NSLog(@"Rotating right column up");
    [self rotateUpwardColumn:2];
    [self rotateSide:(VWWColor*)_right direction:VWWDirectionClockwise];
}
// Affects sides front back top bottom right
-(void)rotateRightColumnDown{
    NSLog(@"Rotating right column down");
    [self rotateDownwardColumn:2];
    [self rotateSide:(VWWColor*)_right direction:VWWDirectionAnticlockwise];
}






// Affects sides front top right bottom left
-(void)rotateFrontSquareClockwise{
    // top = left
    // left = bottom
    // bottom = right
    // right = top
    
    VWWColor tempTop[3] = {kVWWColorWhite,
        kVWWColorWhite,
        kVWWColorWhite};
    tempTop[0] = _top[0][2];
    tempTop[1] = _top[1][2];
    tempTop[2] = _top[2][2];
    
    // top = left
    _top[0][2] = _left[0][0];
    _top[1][2] = _left[0][1];
    _top[2][2] = _left[0][2];
    
    // left = bottom
    _left[0][0] = _bottom[2][0];
    _left[0][1] = _bottom[1][0];
    _left[0][2] = _bottom[0][0];
    
    // bottom = right
    _bottom[2][0] = _right[2][2];
    _bottom[1][0] = _right[2][1];
    _bottom[0][0] = _right[2][0];
    
    // right = top
    _right[2][2] = tempTop[0];
    _right[2][1] = tempTop[1];
    _right[2][0] = tempTop[2];
    
//    [self rotateClockwiseSquare:0];
    // rotate front clockwise

}
// Affects sides front top right bottom left
-(void)rotateFrontSquareAntiClockwise{
    // top = right
    // right = bottom
    // bottom = left
    // left = top
    
    VWWColor tempTop[3] = {kVWWColorWhite,
        kVWWColorWhite,
        kVWWColorWhite};
    tempTop[0] = _top[0][2];
    tempTop[1] = _top[1][2];
    tempTop[2] = _top[2][2];
    
    // top = right
    _top[0][2] = _right[2][2];
    _top[1][2] = _right[2][1];
    _top[2][2] = _right[2][0];
    
    // right = bottom
    _right[2][2] = _bottom[2][0];
    _right[2][1] = _bottom[1][0];
    _right[2][0] = _bottom[0][0];
    
    // bottom = left
    _bottom[2][0] = _left[2][2];
    _bottom[1][0] = _left[2][1];
    _bottom[0][0] = _left[2][0];
    
    // left = top
    _left[2][2] = tempTop[0];
    _left[2][1] = tempTop[1];
    _left[2][0] = tempTop[2];
    
    
    
    // rotate front anticlockwise
}

// Affects sides top right bottom left
-(void)rotateMiddleSquareClockwise{
    // top = left
    // left = bottom
    // bottom = right
    // right = top
    
}
// Affects sides top right bottom left
-(void)rotateMiddleSquareAntiClockwise{
    // top = right
    // right = bottom
    // bottom = left
    // left = top
    
}

// Affects sides back top right bottom left
-(void)rotateBackSquareClockwise{
    // top = left
    // left = bottom
    // bottom = right
    // right = top
    // rotate back anti clockwise
    
}
// Affects sides back top right bottom left
-(void)rotateBackSquareAntiClockwise{
    // top = right
    // right = bottom
    // bottom = left
    // left = top
    // rotate back clockwise
}


// TODO; We should just use a rotation matrix here to be proper
// For now it is just hardcoded but as we grow in size, we'll want to automate
-(void)rotateSide:(VWWColor*)side direction:(VWWDirection)direction{
    VWWColor tempSide[3][3];
    for(int x=0; x<3; x++){
        for(int y=0; y<3; y++){
            tempSide[x][y] = side[x*3 + y];
        }
    }
    
    // rotate top clockwise
    if(direction == VWWDirectionClockwise){
        side[0*3 + 0] = tempSide[0][2];
        side[1*3 + 0] = tempSide[0][1];
        side[2*3 + 0] = tempSide[0][0];
        
        side[0*3 + 1] = tempSide[1][2];
        side[1*3 + 1] = tempSide[1][1];
        side[2*3 + 1] = tempSide[1][0];
        
        side[0*3 + 2] = tempSide[2][2];
        side[1*3 + 2] = tempSide[2][1];
        side[2*3 + 2] = tempSide[2][0];
    }
    else{
        side[0*3 + 0] = tempSide[2][0];
        side[1*3 + 0] = tempSide[2][1];
        side[2*3 + 0] = tempSide[2][2];
        
        side[0*3 + 1] = tempSide[1][0];
        side[1*3 + 1] = tempSide[1][1];
        side[2*3 + 1] = tempSide[1][2];
        
        side[0*3 + 2] = tempSide[0][2];
        side[1*3 + 2] = tempSide[0][1];
        side[2*3 + 2] = tempSide[0][0];
    }
}

@end






