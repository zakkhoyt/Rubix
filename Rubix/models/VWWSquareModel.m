//
//  VWWSquareModel.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/26/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWSquareModel.h"

@implementation VWWSquareModel
-(id)initWithColor:(VWWColor)color atLocation:(NSUInteger)location onFace:(VWWFace)face{
    self = [super init];
    if(self){
        self.color = color;
        self.location = location;
        self.face = face;
    }
    return self;
}

-(NSString*)description{
    NSMutableString* r = [[NSMutableString alloc]init];
    if(self.color = kVWWColorBlue){
        [r appendFormat:@"color=blue "];
    }
    else if(self.color = kVWWColorGreen){
        [r appendFormat:@"color=green "];
    }
    else if(self.color = kVWWColorRed){
        [r appendFormat:@"color=red "];
    }
    else if(self.color = kVWWColorYellow){
        [r appendFormat:@"color=yellow "];
    }
    else if(self.color = kVWWColorWhite){
        [r appendFormat:@"color=white "];
    }
    else if(self.color = kVWWColorOrange){
        [r appendFormat:@"color=orange "];
    }

    
    if(self.face = kVWWFaceBack){
        [r appendFormat:@"face=back "];
    }
    else if(self.face = kVWWFaceBottom){
        [r appendFormat:@"face=bottom "];
    }
    else if(self.face = kVWWFaceFront){
        [r appendFormat:@"face=front "];
    }
    else if(self.face = kVWWFaceLeft){
        [r appendFormat:@"face=left "];
    }
    else if(self.face = kVWWFaceRight){
        [r appendFormat:@"face=right "];
    }
    else if(self.face = kVWWFaceTop){
        [r appendFormat:@"face=top "];
    }

    [r appendFormat:@"location=%d ", self.location];
    
    
    return r;

}
@end
