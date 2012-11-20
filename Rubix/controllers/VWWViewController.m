//
//  VWWViewController.m
//  rubix
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  See tutorial here: http://www.raywenderlich.com/5235/beginning-opengl-es-2-0-with-glkit-part-2
//  iOS6 book here: http://www.raywenderlich.com/store/ios-6-by-tutorials
//  Matrix info here: http://casualdistractiongames.wordpress.com/
//  About rendering multiple objects: http://games.ianterrell.com/2d-game-engine-tutorial/




#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import "VWWCubeScene.h"
#import "VWWViewController.h"
#import "VWWCube.h"
#import "VWWMotionMonitor.h"

const CGFloat kRotateXSensitivity = 0.25f;
const CGFloat kRotateYSensitivity = 0.25f;
const CGFloat kRotateZSensitivity = 0.25f;

@interface VWWViewController () <GLKViewControllerDelegate,
    VWWMotionMonitorDelegate>{
}
@property (nonatomic, retain) EAGLContext * context;
@property (nonatomic, retain) IBOutlet GLKView* view;
@property (nonatomic, retain) VWWMotionMonitor* motionMonitor;
@property (nonatomic) CGPoint touchBegan;
@property (nonatomic) CGPoint touchMoved;
@property (nonatomic) CGPoint touchEnded;
@property (nonatomic, retain) NSTimer* rotateTimer;
@property (nonatomic, retain) VWWCubeScene* cubeScene;

@end

@implementation VWWViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initializeClass];
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self createGLView];
    [self createCubeScene];
    [self.cubeScene setupGL];
    [self.motionMonitor startAccelerometer];
    [self.motionMonitor startGyros];
    [self.motionMonitor startMagnetometer];
}


-(void)viewDidUnload{
    [self.motionMonitor stopAccelerometer];
    [self.motionMonitor stopGyros];
    [self.motionMonitor stopMagnetometer];
    [super viewDidUnload];
    [self.cubeScene tearDownGL];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIResponder touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = [touchesArray objectAtIndex:0];
    self.touchBegan = [touch locationInView:nil];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = [touchesArray objectAtIndex:0];
    self.touchMoved = [touch locationInView:nil];
    CGFloat rotateX = self.touchBegan.x - self.touchMoved.x;
    CGFloat rotateY = self.touchBegan.y - self.touchMoved.y;
    self.cubeScene.rotateX = rotateX * -kRotateXSensitivity;
    self.cubeScene.rotateY = rotateY * -kRotateYSensitivity;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
}

-(void)printMethod:(char*)method withTouches:(NSSet*)touches withEvent:(UIEvent*)event{
    NSArray *touchesArray = [touches allObjects];
    NSMutableString* s = [NSMutableString new];
    for(int index = 0; index < touches.count; index++){
        UITouch *touch = (UITouch *)[touchesArray objectAtIndex:index];
        CGPoint point = [touch locationInView:nil];
        [s appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%s numTouches:%d %@", method, touches.count, s);
    if(touches.count > 2){
        self.paused = !self.paused;
    }
}

#pragma mark - Custom methods

-(void)initializeClass{
    self.motionMonitor = [[VWWMotionMonitor alloc]init];
    self.motionMonitor.delegate = self;
}

-(void)createCubeScene{
    self.cubeScene = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
}

-(void)createGLView{
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.view.context = self.context;
    self.view.delegate = self;
    self.view.drawableColorFormat = GLKViewDrawableColorFormatRGB565;   // consumes less resources than RGBA8888
    self.view.drawableDepthFormat = GLKViewDrawableDepthFormat16;       // probably need this for 3D
}


#pragma mark - Implements GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [self.cubeScene render];
}

#pragma mark - Implements GLKViewControllerDelegate
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause{
    NSLog(@"%s", __FUNCTION__);
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller{
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)update{
    [self.cubeScene update];
}


#pragma mark = Implements VWWMotionMonitorDelegate
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device{
 //   NSLog(@"%@", [self.motionMonitor description:device]);
//    self.translateZ = device.z.current * 2;
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device{
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device{
}
@end
