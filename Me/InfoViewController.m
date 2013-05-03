//
//  InfoViewController.m
//  Me
//
//  Created by Khaos Tian on 4/30/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
    [[UINavigationBar appearance]setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor grayColor],UITextAttributeFont:[UIFont fontWithName:@"Avenir-Light" size:22],UITextAttributeTextShadowColor:[UIColor clearColor]}];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    UINavigationBar *naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToPreviousView) forControlEvents:UIControlEventTouchUpInside];
    UINavigationItem *navitem = [[UINavigationItem alloc]initWithTitle:nil];
    navitem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:backButton]];
    [naviBar setItems:@[navitem]];
    navitem.title = [self.infoDict objectForKey:@"name"];
    [self.view addSubview: naviBar];
    
    self.photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-288-50-187, [UIScreen mainScreen].bounds.size.width, 300)];
    self.photoScrollView.backgroundColor = [UIColor whiteColor];
    [self.photoScrollView setPagingEnabled:YES];
    [self.photoScrollView setShowsHorizontalScrollIndicator:NO];
    [self.photoScrollView setContentSize:CGSizeMake([[self.infoDict objectForKey:@"photos"]count]*[UIScreen mainScreen].bounds.size.width, 237)];
    [self.view addSubview:self.photoScrollView];
    
    for (int count = 0; count < [[self.infoDict objectForKey:@"photos"]count];count++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*count, 0, [UIScreen mainScreen].bounds.size.width, 300)];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.image = [UIImage imageNamed:[[self.infoDict objectForKey:@"photos"]objectAtIndex:count]];
        [self.photoScrollView addSubview:imgView];
    }
    
    UITextView *description = [[UITextView alloc]initWithFrame:CGRectMake(0, self.photoScrollView.bounds.origin.y+self.photoScrollView.bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(self.photoScrollView.bounds.origin.y+self.photoScrollView.bounds.size.height+20))];
    description.text = [self.infoDict objectForKey:@"description"];
    description.font = [UIFont fontWithName: @"Avenir-Light" size: 14.0f];
    description.textColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    description.backgroundColor = [UIColor whiteColor];
    description.editable = NO;
    [self.view addSubview:description];
}

- (void)backToPreviousView
{
    [self.contentController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
