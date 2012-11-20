//
//  VWWViewController.m
//  rubix
//
//  Created by Zakk Hoyt on 11/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  See tutorial here: http://www.raywenderlich.com/5235/beginning-opengl-es-2-0-with-glkit-part-2
//  iOS6 book here: http://www.raywenderlich.com/store/ios-6-by-tutorials

#define VWW_GL_ENABLE_TEXTURES 1
//#define VWW_GL_ENABLE_LIGHTING 1
//#define VWW_GL_ENABLE_COLORS 1


#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import "VWWViewController.h"
#import "VWWCube.h"
#import "VWWMotionMonitor.h"

const CGFloat kRotateXSensitivity = 1.25f;
const CGFloat kRotateYSensitivity = 0.25f;
const CGFloat kRotateZSensitivity = 0.25f;


typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2];
    float Normal[3];
} Vertex;

const Vertex Vertices[] = {
    // Front
    {{1, -1, 1}, {1, 0, 0, 1}, {1, 0}, {0, 0, 1}},
    {{1, 1, 1}, {0, 1, 0, 1}, {1, 1}, {0, 0, 1}},
    {{-1, 1, 1}, {0, 0, 1, 1}, {0, 1}, {0, 0, 1}},
    {{-1, -1, 1}, {0, 0, 0, 1}, {0, 0}, {0, 0, 1}},
    // Back
    {{1, 1, -1}, {1, 0, 0, 1}, {0, 1}, {0, 0, -1}},
    {{-1, -1, -1}, {0, 1, 0, 1}, {1, 0}, {0, 0, -1}},
    {{1, -1, -1}, {0, 0, 1, 1}, {0, 0}, {0, 0, -1}},
    {{-1, 1, -1}, {0, 0, 0, 1}, {1, 1}, {0, 0, -1}},
    // Left
    {{-1, -1, 1}, {1, 0, 0, 1}, {1, 0}, {-1, 0, 0}},
    {{-1, 1, 1}, {0, 1, 0, 1}, {1, 1}, {-1, 0, 0}},
    {{-1, 1, -1}, {0, 0, 1, 1}, {0, 1}, {-1, 0, 0}},
    {{-1, -1, -1}, {0, 0, 0, 1}, {0, 0}, {-1, 0, 0}},
    // Right
    {{1, -1, -1}, {1, 0, 0, 1}, {1, 0}, {1, 0, 0}},
    {{1, 1, -1}, {0, 1, 0, 1}, {1, 1}, {1, 0, 0}},
    {{1, 1, 1}, {0, 0, 1, 1}, {0, 1}, {1, 0, 0}},
    {{1, -1, 1}, {0, 0, 0, 1}, {0, 0}, {1, 0, 0}},
    // Top
    {{1, 1, 1}, {1, 0, 0, 1}, {1, 0}, {0, 1, 0}},
    {{1, 1, -1}, {0, 1, 0, 1}, {1, 1}, {0, 1, 0}},
    {{-1, 1, -1}, {0, 0, 1, 1}, {0, 1}, {0, 1, 0}},
    {{-1, 1, 1}, {0, 0, 0, 1}, {0, 0}, {0, 1, 0}},
    // Bottom
    {{1, -1, -1}, {1, 0, 0, 1}, {1, 0}, {0, -1, 0}},
    {{1, -1, 1}, {0, 1, 0, 1}, {1, 1}, {0, -1, 0}},
    {{-1, -1, 1}, {0, 0, 1, 1}, {0, 1}, {0, -1, 0}},
    {{-1, -1, -1}, {0, 0, 0, 1}, {0, 0}, {0, -1, 0}}
};
const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 6, 5,
    4, 5, 7,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};
    
    
    
@interface VWWViewController () <GLKViewControllerDelegate,
    VWWMotionMonitorDelegate>{

}

@property (nonatomic) GLuint vertexArray;
@property (nonatomic) GLuint vertexBuffer;
@property (nonatomic) GLuint indexBuffer;
@property (nonatomic, retain) VWWCube* cube;
@property (nonatomic, retain) EAGLContext * context;
@property (nonatomic, retain) IBOutlet GLKView* view;
@property (nonatomic, retain) GLKBaseEffect* effect;
@property (nonatomic, retain) VWWMotionMonitor* motionMonitor;
@property (nonatomic) CGPoint touchBegan;
@property (nonatomic) CGPoint touchMoved;
@property (nonatomic) CGPoint touchEnded;
@property (nonatomic) CGFloat rotateX;
@property (nonatomic) CGFloat rotateY;
@property (nonatomic) CGFloat rotateZ;
@property (nonatomic) CGFloat translateX;
@property (nonatomic) CGFloat translateY;
@property (nonatomic) CGFloat translateZ;
@property (nonatomic) CGFloat colorX;
@property (nonatomic) CGFloat colorY;
@property (nonatomic) CGFloat colorZ;
@property (nonatomic, retain) NSTimer* rotateTimer;

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
    _rotateX = self.touchBegan.x - self.touchMoved.x;
    _rotateY = self.touchBegan.y - self.touchMoved.y;
    _rotateX *= -kRotateXSensitivity;
    _rotateY *= -kRotateYSensitivity;
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
    self.rotationRateX = @(0.25);
    
    self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(rotateTimerFire) userInfo:nil repeats:YES];
}

-(void)createCube{
    self.cube = [[VWWCube alloc]init];
}

-(void)createGLView{
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.view.context = self.context;
    self.view.delegate = self;
    self.view.drawableColorFormat = GLKViewDrawableColorFormatRGB565;   // consumes less resources than RGBA8888
    self.view.drawableDepthFormat = GLKViewDrawableDepthFormat16;       // probably need this for 3D
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    
#if defined(VWW_GL_ENABLE_TEXTURES)
    NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithBool:YES],
                              GLKTextureLoaderOriginBottomLeft,
                              nil];
    NSError * error;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"3x3_01" ofType:@"png"];
    GLKTextureInfo * info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", [error localizedDescription]);
    }
    self.effect.texture2d0.name = info.name;
    self.effect.texture2d0.enabled = true;
#endif
    
    
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
#if defined(VWW_GL_ENABLE_COLORS)
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          4,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          offsetof(Vertex, Color));
#endif

    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)offsetof(Vertex, Normal));
    
#if defined(VWW_GL_ENABLE_TEXTURES)
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0,
                          2,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)offsetof(Vertex, TexCoord));
#endif
    
    glBindVertexArrayOES(0);
    
    // Enable texture winding
    glEnable(GL_CULL_FACE);
    
    // Setup a light (dont' forget the normals!)
#if defined(VWW_GL_ENABLE_LIGHTING)
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(0, 1, 1, 1);
    self.effect.light0.ambientColor = GLKVector4Make(0, 0, 0, 1);
//    self.effect.light0.specularColor = GLKVector4Make(0, 0, 0, 1);
//    self.effect.lightModelAmbientColor = GLKVector4Make(0, 0, 0, 1);
//   self.effect.material.specularColor = GLKVector4Make(1, 1, 1, 1);
    self.effect.light0.position = GLKVector4Make(10, 10, -8, 1);
//    self.effect.lightingType = GLKLightingTypePerPixel;
#endif
}

- (void)tearDownGL {
    
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
    
    [self.effect release];
    
}

-(void)rotateTimerFire{
    NSLog(@"%s", __FUNCTION__   );
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
#if defined(VWW_GL_ENABLE_COLORS)
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          4,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          (const GLvoid *)
                          offsetof(Vertex, Color));
#endif
    
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
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(self.rotateY), 1, 0, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(self.rotateX), 0, 1, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(self.rotateZ), 0, 0, 1);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
}


#pragma mark = Implements VWWMotionMonitorDelegate
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device{
//    float sensitivity = 100;
//    _rotationX = sensitivity * device.y.current;
//    _rotationY = -sensitivity * device.x.current;
////    _rotationZ = 30 * device.z.current;

}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device{
//    float sensitivity = 400;
//    _colorX = abs(device.x.current)/sensitivity;
//    _colorY = abs(device.y.current)/sensitivity;
//    _colorZ = abs(device.z.current)/sensitivity;
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device{
//    float accelerometerSensitivity = 2.0;
//    _translateX = accelerometerSensitivity * device.x.current;
//    _translateY = accelerometerSensitivity * device.y.current * 2.0;
//    _translateZ = accelerometerSensitivity * device.z.current * 2.0;
}



@end
