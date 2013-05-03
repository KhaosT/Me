//
//  ContentViewController.m
//  Me
//
//  Created by Khaos Tian on 4/25/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "ContentViewController.h"
#import "NameViewController.h"
#import "MyProjectViewController.h"
#import "LocationViewController.h"
#import "DetailTagViewController.h"

@interface ContentViewController (){
    UIScrollView            *_scrollview;
    NameViewController      *_nameViewController;
    LocationViewController  *_locationViewController;
    DetailTagViewController *_detailTagViewController;
    MyProjectViewController *_projectViewController;
}

@end

@implementation ContentViewController

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
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)];
    _scrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Content-BG.png"]];
    _scrollview.pagingEnabled = YES;
    _scrollview.scrollsToTop = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height-20);
    [self.view addSubview:_scrollview];
    
    _nameViewController = [[NameViewController alloc]initWithNibName:nil bundle:nil];
    [self addChildViewController:_nameViewController];
    [_scrollview addSubview:_nameViewController.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_nameViewController startAnimation];
    
    dispatch_queue_t gQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(gQueue, ^{
        _locationViewController = [[LocationViewController alloc]initWithNibName:nil bundle:nil];
        _detailTagViewController = [[DetailTagViewController alloc]initWithNibName:nil bundle:nil];
        _projectViewController = [[MyProjectViewController alloc]initWithNibName:nil bundle:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addChildViewController:_locationViewController];
            [_scrollview addSubview:_locationViewController.view];
            
            [self addChildViewController:_detailTagViewController];
            [_scrollview addSubview:_detailTagViewController.view];
            
            [self addChildViewController:_projectViewController];
            [_scrollview addSubview:_projectViewController.view];
        });
    });
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollview]) {
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / pageWidth;
        
        switch (page) {
            case 1:
                [_locationViewController didScrollToTheView];
                break;
            
            case 2:
                [_detailTagViewController startAnimation];
                break;
                
            default:
                break;
        }
    }
}

@end
