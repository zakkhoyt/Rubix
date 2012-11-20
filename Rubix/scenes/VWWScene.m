//
//  VWWScene.m
//  Rubix
//
//  Created by Zakk Hoyt on 11/20/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWScene.h"

@interface VWWScene ()

@end

@implementation VWWScene


-(id)initWithFrame:(CGRect)frame context:(EAGLContext *)context{
    self = [super init];
    if(self){
        self.bounds = frame;
        self.context = context;
        self.clearColor = [UIColor blackColor];
    }
    return self;
}


-(void)update {
    NSLog(@"ERROR! Up to child class to implement");
}

-(void)render {
    NSLog(@"ERROR! Up to child class to implement");
}

- (void)setupGL{
    NSLog(@"ERROR! Up to child class to implement");
}

- (void)tearDownGL{
    NSLog(@"ERROR! Up to child class to implement");
}

@end
