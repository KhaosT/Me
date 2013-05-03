//
//  LocationViewController.m
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "LocationViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface LocationViewController (){
    UIImageView     *_locationBG;
    
    UIButton        *_locationPointer;
    
    MKMapView       *_mapView;
    
    UILabel         *_title;
    
    BOOL            animated;
}

@end

@implementation LocationViewController

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
    self.view = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    self.view.backgroundColor = [UIColor clearColor];
    
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(25, [UIScreen mainScreen].bounds.size.height/2-140-20-30+3, 270, 270)];
    
    //Workaround for Zoomin animation on real device.
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(22.547470, 114.049994), MKCoordinateSpanMake(100, 100))];
    
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _locationBG = [[UIImageView alloc]initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height/2-140-20-30, 280, 280)];
    _locationBG.image = [[UIImage imageNamed:@"location-bg.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(9, 9, 12, 50)];
    [self.view addSubview:_locationBG];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(30, [UIScreen mainScreen].bounds.size.height/2+140-60, 280, 80)];
    _title.backgroundColor = [UIColor clearColor];
    _title.textColor = /*[UIColor colorWithRed:112.0/255.0 green:210.0/255.0 blue:1 alpha:1];*/[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    _title.text = @"Where am I";
    _title.font = [UIFont fontWithName: @"Avenir-Light" size: 50];
    [self.view addSubview:_title];
    
    _locationPointer = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 46, 74)];
    [_locationPointer setImage:[UIImage imageNamed:@"location_pointer.png"] forState:UIControlStateNormal];
    [_locationPointer addTarget:self action:@selector(scrollToDestRect) forControlEvents:UIControlEventTouchUpInside];
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        _locationPointer.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, _title.center.y+80);
    }else{
        _locationPointer.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, _title.center.y+60);
    }
    [self.view addSubview:_locationPointer];
}

- (void)didScrollToTheView
{
    if (!animated) {
        animated = YES;
        [self scrollToDestRect];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(22.547470, 114.049994);
        point.title = @"Shenzhen";
        [_mapView addAnnotation:point];
    }
}

- (void)scrollToDestRect
{
    [_mapView setRegion:[_mapView regionThatFits: MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(22.547470, 114.049994), 80000, 80000)] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    animated = NO;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
