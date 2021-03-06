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
#import "VWWCubeModel.h"
#import "VWWMotionMonitor.h"


const CGFloat kRotateXSensitivity = 0.25f;
const CGFloat kRotateYSensitivity = 0.25f;
const CGFloat kRotateZSensitivity = 0.25f;

@interface VWWViewController () <GLKViewControllerDelegate,
    VWWMotionMonitorDelegate>{
}
@property (nonatomic, strong) EAGLContext * context;
@property (nonatomic, strong) IBOutlet GLKView* view;
@property (nonatomic, strong) VWWMotionMonitor* motionMonitor;
@property (nonatomic) CGPoint touchBegan;
@property (nonatomic) CGPoint touchMoved;
@property (nonatomic) CGPoint touchEnded;
@property (nonatomic, strong) NSTimer* rotateTimer;
@property (nonatomic, strong) NSMutableArray* cubes;

- (IBAction)diffuseSliderChanged:(id)sender;
- (IBAction)ambientSliderChanged:(id)sender;
- (IBAction)specularValueChanged:(id)sender;
- (IBAction)shinyValueChanged:(id)sender;
- (IBAction)cutoffValueChanged:(id)sender;
- (IBAction)exponentValueChanged:(id)sender;
- (IBAction)constantValueChanged:(id)sender;
- (IBAction)linearValueChanged:(id)sender;
- (IBAction)quadraticValueChanged:(id)sender;

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

    [self.cubes makeObjectsPerformSelector:@selector(setupGL)];
    [self.motionMonitor startAccelerometer];
    [self.motionMonitor startGyros];
    [self.motionMonitor startMagnetometer];
}


-(void)viewDidUnload{
    [self.motionMonitor stopAccelerometer];
    [self.motionMonitor stopGyros];
    [self.motionMonitor stopMagnetometer];
    [super viewDidUnload];
    [self.cubes makeObjectsPerformSelector:@selector(tearDownGL)];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIResponder touch events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    self.touchBegan = [touch locationInView:nil];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self printMethod:(char*)__FUNCTION__ withTouches:touches withEvent:event];
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    self.touchMoved = [touch locationInView:nil];
    CGFloat rotateX = self.touchBegan.x - self.touchMoved.x;
    CGFloat rotateY = self.touchBegan.y - self.touchMoved.y;
    for(VWWCubeScene* cube in self.cubes){
        cube.rotate = GLKVector3Make(rotateX, rotateY, 0);
    }
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
        UITouch *touch = (UITouch *)touchesArray[index];
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
    
    self.cubes = [[NSMutableArray alloc] init];

    float cubeWidth = 4.0;
    float z = 1;
    VWWCubeScene* cubes[28] = {};

    
    
    cubes[0] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
    cubes[0].translate = GLKVector3Make(0, 0, 13);
    [self.cubes addObject:cubes[0]];

    
    
//    cubes[0] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[0].translate = GLKVector3Make(-cubeWidth, cubeWidth, z);
//    [self.cubes addObject:cubes[0]];
//
//    cubes[1] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[1].translate = GLKVector3Make(0, cubeWidth, z);
//    [self.cubes addObject:cubes[1]];
//    
//    cubes[2] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[2].translate = GLKVector3Make(cubeWidth, cubeWidth, z);
//    [self.cubes addObject:cubes[2]];
//    
//    cubes[3] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[3].translate = GLKVector3Make(-cubeWidth, 0, z);
//    [self.cubes addObject:cubes[3]];
//    
//    cubes[4] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[4].translate = GLKVector3Make(0, 0, z);
//    [self.cubes addObject:cubes[4]];
//    
//    cubes[5] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[5].translate = GLKVector3Make(cubeWidth, 0, z);
//    [self.cubes addObject:cubes[5]];
//    
//    cubes[6] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[6].translate = GLKVector3Make(-cubeWidth, -cubeWidth, z);
//    [self.cubes addObject:cubes[6]];
//    
//    cubes[7] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[7].translate = GLKVector3Make(0, -cubeWidth, z);
//    [self.cubes addObject:cubes[7]];
//    
//    cubes[8] = [[VWWCubeScene alloc]initWithFrame:self.view.frame context:self.context];
//    cubes[8].translate = GLKVector3Make(cubeWidth, -cubeWidth, z);
//    [self.cubes addObject:cubes[8]];


    
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
    glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);
    [self.cubes makeObjectsPerformSelector:@selector(render)];
}

#pragma mark - Implements GLKViewControllerDelegate
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause{
    NSLog(@"%s", __FUNCTION__);
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller{
    NSLog(@"%s", __FUNCTION__);
}

- (void)update{
    [self.cubes makeObjectsPerformSelector:@selector(update)];
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
- (IBAction)diffuseSliderChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
//    self.cubeScene.lightDiffuse = slider.value;
}

- (IBAction)ambientSliderChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
//  self.cubeScene.lightAmbient = slider.value;
}

- (IBAction)specularValueChanged:(id)sender {
 //   UISlider* slider = (UISlider*)sender;
//    self.cubeScene.lightSpecular = slider.value;
}

- (IBAction)shinyValueChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
}

- (IBAction)cutoffValueChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
}

- (IBAction)exponentValueChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
}

- (IBAction)constantValueChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
}

- (IBAction)linearValueChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
}

- (IBAction)quadraticValueChanged:(id)sender {
//    UISlider* slider = (UISlider*)sender;
}
@end
