//
//  VWWViewController.m
//  rubix
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  See tutorial here: http://www.raywenderlich.com/5235/beginning-opengl-es-2-0-with-glkit-part-2
//  iOS6 book here: http://www.raywenderlich.com/store/ios-6-by-tutorials
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import "VWWViewController.h"
#import "VWWCube.h"
#import "VWWMotionMonitor.h"
\
typedef struct {
    float Position[3];
    float Color[4];
    float Normal[3];
} Vertex;

const Vertex Vertices[] = {
    // back
    {{-1, -1, -1}, {1, 0, 0, 1}, {0, 0, -1}},
    {{-1, 1, -1}, {0, 1, 0, 1}, {0, 0, -1}},
    {{1, 1, -1}, {0, 0, 1, 1}, {0, 0, -1}},
    {{1, -1, -1}, {0, 0, 0, 1}, {0, 0, -1}},
    // top
    {{1, 1, 1}, {1, 0, 0, 1}, {0, 1, 0}},
    {{1, 1, -1}, {0, 1, 0, 1}, {0, 1, 0}},
    {{-1, 1, -1}, {0, 0, 1, 1}, {0, 1, 0}},
    {{-1, 1, 1}, {0, 0, 0, 1}, {0, 1, 0}},
    // bottom
    {{1, -1, 1}, {1, 0, 0, 1}, {0, -1, 0}},
    {{-1, -1, 1}, {0, 1, 0, 1}, {0, -1, 0}},
    {{-1, -1, -1}, {0, 0, 1, 1}, {0, -1, 0}},
    {{1, -1, -1}, {0, 0, 0, 1}, {0, -1, 0}},
    // left
    {{-1, -1, -1}, {1, 0, 0, 1}, {-1, 0, 0}},
    {{-1, -1, 1}, {0, 1, 0, 1}, {-1, 0, 0}},
    {{-1, 1, 1}, {0, 0, 1, 1}, {-1, 0, 0}},
    {{-1, 1, -1}, {0, 0, 0, 1}, {-1, 0, 0}},
    // right
    {{1, -1, -1}, {1, 0, 0, 1}, {1, 0, 0}},
    {{1, 1, -1}, {0, 1, 0, 1}, {1, 0, 0}},
    {{1, 1, 1}, {0, 0, 1, 1}, {1, 0, 0}},
    {{1, -1, 1}, {0, 0, 0, 1}, {1, 0, 0}},
    // front
    {{1, -1, 1}, {1, 0, 0, 1}, {0, 0, 1}},
    {{1, 1, 1}, {0, 1, 0, 1}, {0, 0, 1}},
    {{-1, 1, 1}, {0, 0, 1, 1}, {0, 0, 1}},
    {{-1, -1, 1}, {0, 0, 0, 1}, {0, 0, 1}},
};

// Draw triangles with the data above
const GLubyte Indices[] = {
    0, 1, 2,
    2, 3, 0,
    4, 5, 6,
    6, 7, 4,
    8, 9, 10,
    10, 11, 8,
    12, 13, 14,
    14, 15, 12,
    16, 17, 18,
    18, 19, 16,
    20, 21, 22,
    22, 23, 20,
};



@interface VWWViewController () <GLKViewControllerDelegate,
    VWWMotionMonitorDelegate>{
        GLuint _vertexArray;
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
    self.view.drawableColorFormat = GLKViewDrawableColorFormatRGB565;   // consumes less resources than 8888
    self.view.drawableDepthFormat = GLKViewDrawableDepthFormat16;       // probably need this for 3D
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    // New lines
    glGenVertexArraysOES(1, &_vertexArray); glBindVertexArrayOES(_vertexArray);
    
    // Old stuff
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
    // New lines (were previously in draw)
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          offsetof(Vertex, Position));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          4,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          offsetof(Vertex, Color));
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)offsetof(Vertex, Normal));
    
    
    glBindVertexArrayOES(0);
    
    // Enable texture winding
    glEnable(GL_CULL_FACE);
    
    // Setup a light (dont' forget the normals!)
//    self.effect.light0.enabled = GL_TRUE;
//    self.effect.light0.diffuseColor = GLKVector4Make(1, 1, 1, 1.0);
//    self.effect.light0.position = GLKVector4Make(1, 1, 0, 1);
    
    self.effect.light0.enabled = GL_TRUE;
//    self.effect.light0.diffuseColor = GLKVector4Make(0, 1, 1, 1);
//    self.effect.light0.ambientColor = GLKVector4Make(0, 0, 0, 1);
//    self.effect.light0.specularColor = GLKVector4Make(0, 0, 0, 1);
//    self.effect.lightModelAmbientColor = GLKVector4Make(0, 0, 0, 1);
//   self.effect.material.specularColor = GLKVector4Make(1, 1, 1, 1);
    self.effect.light0.position = GLKVector4Make(0, 1.5, -5, 1);
    self.effect.lightingType = GLKLightingTypePerPixel;
}

- (void)tearDownGL {
    
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
    
    [self.effect release];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.paused = !self.paused;
}

#pragma mark - Implements GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
//    NSLog(@"%s", __FUNCTION__);
    glClearColor(_colorX, _colorY, _colorZ, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    // Important! Must call any time you change proper-
    // ties on a GLKBaseEffect, before you draw with it.
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
    
    glBindVertexArrayOES(_vertexArray);
    glDrawElements(GL_TRIANGLES,
                   sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    
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
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.0f, 20.0f);
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
    float accelerometerSensitivity = 2.0;
    _translateX = accelerometerSensitivity * device.x.current;
    _translateY = accelerometerSensitivity * device.y.current * 2.0;
    _translateZ = accelerometerSensitivity * device.z.current * 2.0;
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device{
    _colorX = abs(device.x.current)/400.0;
    _colorY = abs(device.y.current)/400.0;
    _colorZ = abs(device.z.current)/400.0;
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device{
    _rotationX = 30 * device.x.current;
    _rotationY = 30 * device.y.current;
    _rotationZ = 30 * device.z.current;
}

@end
