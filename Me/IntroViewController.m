//
//  IntroViewController.m
//  Me
//
//  Created by Khaos Tian on 4/25/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "IntroViewController.h"
#import "ContentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface IntroViewController (){
    UIImageView        *_enter;
    
    UIImageView        *_socket;
    
    CFTimeInterval  _lastAnimationTime;
    
    BOOL            _moving;
}

@end

@implementation IntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _moving = NO;
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    bg.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:bg];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _socket = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 115, 115)];
    [_socket setImage:[UIImage imageNamed:@"socket.png"]];
    if ([UIScreen mainScreen].bounds.size.height >= 568) {
        _socket.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-180);
    }else{
        _socket.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-140);
    }
    [self.view addSubview:_socket];
    
    _enter = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-48.5, [UIScreen mainScreen].bounds.size.height/2-49.5-20-80, 97, 99)];
    [_enter setImage:[UIImage imageNamed:@"avatar.png"]];
    _enter.layer.shadowOffset = CGSizeMake(0, 0);
    _enter.layer.shadowOpacity = 0.8;
    _enter.layer.shadowRadius = 20.0f;
    _enter.layer.shadowColor = [UIColor colorWithRed:32.0/255.0 green:184.0/255.0 blue:1.0 alpha:1.0].CGColor;
    [self.view addSubview:_enter];
        
    [self addBreathAnimationForLayer:_enter.layer beginTime:0];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        _lastAnimationTime = [_enter.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        [_enter.layer removeAllAnimations];
    }];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self addBreathAnimationForLayer:_enter.layer beginTime:[_enter.layer convertTime:CACurrentMediaTime() fromLayer:nil] - _lastAnimationTime];
    }];
}

- (void)enter:(id)sender
{
    [self moveAvatarToPoint:_socket.center inTime:0.3f];
    [UIView animateWithDuration:0.6
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         self.view.alpha = 0;
     }
                     completion:^(BOOL finished) {
                         [self.navigationController pushViewController:[[ContentViewController alloc]initWithNibName:nil bundle:nil] animated:NO];
                     }];
}

- (void)addBreathAnimationForLayer:(CALayer *)layer beginTime:(CFTimeInterval)time
{
    CABasicAnimation *breathAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    breathAnimation.duration = 2;
    breathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    breathAnimation.toValue = [NSNumber numberWithFloat:1.0];
    breathAnimation.beginTime = time;
    breathAnimation.repeatCount = HUGE_VALF;
    breathAnimation.autoreverses = YES;
    [layer addAnimation:breathAnimation forKey:nil];
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveAvatarToPoint:(CGPoint)point inTime:(float)time
{
    UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(_enter.center.x, _enter.center.y)];
	[path addLineToPoint:point];
	
	CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	moveAnimation.path = path.CGPath;
	moveAnimation.duration = time;
    [_enter.layer removeAnimationForKey:@"moveAnimation"];
    
	[_enter.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    _enter.center = point;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.view];
    CGFloat distance = DistanceBetweenTwoPoints(currentLocation,_enter.center);
    if (distance<50) {
        _moving = YES;
        [self moveAvatarToPoint:currentLocation inTime:0.1];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_moving) {
        UITouch *touch = [touches anyObject];
        CGPoint currentLocation = [touch locationInView:self.view];
        _enter.center = currentLocation;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _moving = NO;
    CGFloat distance = DistanceBetweenTwoPoints(_enter.center, _socket.center);
    if (distance<50) {
        [self enter:nil];
    }else{
        [self moveAvatarToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-20-80) inTime:0.3f];
    }
}

CGFloat DistanceBetweenTwoPoints(CGPoint point1,CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
};

@end
