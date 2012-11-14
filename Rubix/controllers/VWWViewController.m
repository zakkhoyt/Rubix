//
//  VWWViewController.m
//  rubix
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  See tutorial here: http://www.raywenderlich.com/5235/beginning-opengl-es-2-0-with-glkit-part-2
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import "VWWViewController.h"
#import "VWWCube.h"
#import "VWWMotionMonitor.h"



typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

const Vertex Vertices1[] = {
    {{1, -1, 0}, {1, 0, 0, 1}},
    {{1, 1, 0}, {0, 1, 0, 1}},
    {{-1, 1, 0}, {0, 0, 1, 1}},
    {{-1, -1, 0}, {0, 0, 0, 1}}
};

const Vertex Vertices2[] = {
    {{1, 1, 0}, {1, 0, 0, 1}},
    {{1, 3, 0}, {0, 1, 0, 1}},
    {{-1, 3, 0}, {0, 0, 1, 1}},
    {{-1, 1, 0}, {0, 0, 0, 1}}
};

const GLubyte Indices1[] = {
    0, 1, 2,
    2, 3, 0
};

const GLubyte Indices2[] = {
    0, 1, 2,
    2, 3, 0
};




@interface VWWViewController () <GLKViewControllerDelegate,
    VWWMotionMonitorDelegate>{
        GLuint _vertexBuffer;
        GLuint _indexBuffer;
        float _rotationX;
        float _rotationY;
        float _rotationZ;
        float _translateX;
        float _translateY;
        float _translateZ;
        float _colorX;
        float _colorY;
        float _colorZ;
        
}
@property (nonatomic, retain) VWWCube* cube;
@property (nonatomic, retain) EAGLContext * context;
@property (nonatomic, retain) IBOutlet GLKView* view;
@property (nonatomic, retain) GLKBaseEffect* effect;
@property (nonatomic, retain) VWWMotionMonitor* motionMonitor;
@end

@implementation VWWViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initializeClass];
        [self createCube];
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self createGLView];    
    [self setupGL];
    [self.motionMonitor startAccelerometer];
    [self.motionMonitor startGyros];
    [self.motionMonitor startMagnetometer];
}


-(void)viewDidUnload{
    [self.motionMonitor stopAccelerometer];
    [self.motionMonitor stopGyros];
    [self.motionMonitor stopMagnetometer];
    [super viewDidUnload];
    [self tearDownGL];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom methods

-(void)initializeClass{
    self.motionMonitor = [[VWWMotionMonitor alloc]init];
    self.motionMonitor.delegate = self;
    self.rotationRateX = @(0.25);
}

-(void)createCube{
    self.cube = [[VWWCube alloc]init];
}

-(void)createGLView{
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.view.context = self.context;
    self.view.delegate = self;
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices1), Vertices1, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices1), Indices1, GL_STATIC_DRAW);
    
    self.effect = [[GLKBaseEffect alloc] init];
}

- (void)tearDownGL {
    
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
    
    self.effect = [[GLKBaseEffect alloc] init];
    
}


#pragma mark - Implements GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
//    NSLog(@"%s", __FUNCTION__);
    glClearColor(_colorX, _colorY, _colorZ, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self.effect prepareToDraw];
    
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)offsetof(Vertex, Position));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          4,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)
                          offsetof(Vertex, Color));
    
    glDrawElements(GL_TRIANGLES,
                   sizeof(Indices1)/sizeof(Indices1[0]),
                   GL_UNSIGNED_BYTE,
                   0);
    
}

#pragma mark - Implements GLKViewControllerDelegate
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause{
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller{
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)update{
//    NSLog(@"%s", __FUNCTION__);
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 4.0f, 10.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -6.0f);
    

    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, _translateX, _translateY, _translateZ);
    
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotationX), 1, 0, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotationY), 0, 1, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotationZ), 0, 0, 1);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
  
    

}


#pragma mark = Implements VWWMotionMonitorDelegate
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device{
    //_rotation = 90 * device.x.current;
    _translateX = device.x.current;
    _translateY = device.y.current * 2.0;
    _translateZ = device.z.current * 2.0;
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device{
    _colorX = abs(device.x.current)/40.0;
    _colorY = abs(device.y.current)/40.0;
    _colorZ = abs(device.z.current)/40.0;
//    NSLog(@"%f", _colorX);
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device{
    //NSLog(@"x=%f y=%f z=%f", device.x.current, device.y.current, device.z.current);
    _rotationX = 30 * device.x.current;
    _rotationY = 30 * device.y.current;
    _rotationZ = 30 * device.z.current;
}

@end
