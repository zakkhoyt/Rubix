//
//  VWWCubeViewController.m
//  rubix
//
//  Created by Zakk Hoyt on 11/13/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "VWWCube.h"
#import "VWWCubeViewController.h"

@interface VWWCubeViewController () <GLKViewDelegate>
@property (nonatomic, retain) VWWCube* cube;
@property (nonatomic, retain) GLKView* glView;
@end

@implementation VWWCubeViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self createCube];
        [self createGLView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.glView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom methods
-(void)createCube{
    self.cube = [[VWWCube alloc]init];
}

-(void)createGLView{
    EAGLContext * context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.glView = [[GLKView alloc] initWithFrame:self.view.bounds];
    self.glView.context = context;
    self.glView.delegate = self;
    self.view = self.glView;
}


#pragma mark - Implements GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(1.0, 1.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
}

#pragma mark - Implements GLKViewControllerDelegate
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause{
    
}
- (void)glkViewControllerUpdate:(GLKViewController *)controller{
    
}
@end
