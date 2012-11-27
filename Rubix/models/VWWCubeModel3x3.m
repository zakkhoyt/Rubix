//
//  VWWCubeModel3x3.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWCubeModel3x3.h"

@interface VWWCubeModel3x3 ()
@property (nonatomic, retain) VWWCubeModel3x3* cube;
@end

@implementation VWWCubeModel3x3

// Perform a rotation
-(void)rotateSlice:(VWWRotate3x3)rotate{
    switch(rotate){
        case VWWRotate3x3Front:
            break;
        case VWWRotate3x3FrontPrime:
            break;
        case VWWRotate3x3Right:
            break;
        case VWWRotate3x3RightPrime:
            break;
        case VWWRotate3x3Back:
            break;
        case VWWRotate3x3BackPrime:
            break;
        case VWWRotate3x3Left:
            break;
        case VWWRotate3x3LeftPrime:
            break;
        case VWWRotate3x3Top:
            break;
        case VWWRotate3x3TopPrime:
            break;
        default:
            break;
    }
}


//-(void)rotateTop{
//    
////    NSMutableArray* faces[kNumFaces];
////    [self.cube sortSquaresByFaceAndLocation];
////    [self.cube breakSquaresIntoFaceArraysFront:&faces[0]
////                                    right:&faces[1]
////                                     back:&faces[2]
////                                     left:&faces[3]
////                                      top:&faces[4]
////                                   bottom:&faces[5]];
////    
////    [self.squares removeAllObjects];
////    for(NSUInteger index = 0; index < kNumFaces; index++){
////        [faces[index] sortUsingComparator:^(id obj1, id obj2) {
////            VWWSquareModel* square1 = (VWWSquareModel*)obj1;
////            VWWSquareModel* square2 = (VWWSquareModel*)obj2;
////            return square1.location < square2.location ? NSOrderedAscending : NSOrderedDescending;
////        }];
////        [self.squares addObjectsFromArray:faces[index]];
////    }
//
//}

@end
