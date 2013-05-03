//
//  NameViewController.m
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "NameViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NameViewController (){
    UIImageView     *_avatar;
    UILabel         *_name;
    UIImageView     *_ornament;
    UIImageView     *_arrow;
    NSTimer         *_helpTimer;
}

@end

@implementation NameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    self.view.backgroundColor = [UIColor clearColor];
    
    _avatar = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-48.5, [UIScreen mainScreen].bounds.size.height/2-49.5-80, 97, 99)];
    [_avatar setImage:[UIImage imageNamed:@"avatar.png"]];
    [self.view addSubview:_avatar];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 50)];
    _name.backgroundColor = [UIColor clearColor];
    _name.textColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    _name.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-10);
    _name.font = [UIFont fontWithName: @"Avenir-Light" size: 28];
    _name.text = @"Tian Zhang";
    [self.view addSubview:_name];
    
    _ornament = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name-ornament.png"]];
    _ornament.center = CGPointMake(_name.center.x, _name.center.y+35);
    _ornament.alpha = 0;
    [self.view addSubview:_ornament];
}

- (void)startAnimation
{
    _helpTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showNextArrow) userInfo:nil repeats:NO];
                  
	CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.6f;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.01],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    [_avatar.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(_name.center.x, [UIScreen mainScreen].bounds.size.height)];
	[path addLineToPoint:CGPointMake(_name.center.x, _name.center.y)];
	
	CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	moveAnimation.path = path.CGPath;
	moveAnimation.duration = 0.3f;
    
	[_name.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         _ornament.alpha = 1;
     }
                     completion:nil];
}

- (void)showNextArrow
{
    if (_helpTimer != nil) {
        [_helpTimer invalidate];
        _helpTimer = nil;
    }
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"next.png"]];
        _arrow.center = CGPointMake([UIScreen mainScreen].bounds.size.width-_arrow.frame.size.width-10, [UIScreen mainScreen].bounds.size.height/2);
        [self.view addSubview:_arrow];
    }
    
    CABasicAnimation *breathAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    breathAnimation.duration = 2;
    breathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    breathAnimation.toValue = [NSNumber numberWithFloat:1.0];
    breathAnimation.beginTime = 0;
    breathAnimation.repeatCount = HUGE_VALF;
    breathAnimation.autoreverses = YES;
    [_arrow.layer addAnimation:breathAnimation forKey:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [_arrow.layer removeAllAnimations];
    }];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self showNextArrow];
    }];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
