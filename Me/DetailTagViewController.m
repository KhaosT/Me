//
//  DetailTagViewController.m
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "DetailTagViewController.h"
#import "EduCell.h"
#import "TagCell.h"
#import "SectionHeader.h"

@interface DetailTagViewController (){
    UICollectionView        *_detailTagsViewController;
    NSDictionary            *_details;
    
    BOOL                    _animated;
    
    UIImageView             *_ornament_top;
    UIImageView             *_ornament_bottom;
}

@end

@implementation DetailTagViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _details = @{@"skills": @[@"Objective-C",@"Python",@"C",@"C++",@"PHP",@"HTML",@"Photoshop"],@"interests":@[@"User Interface Design",@"Software Development",@"Hardware Development",@"Travel",@"Music",@"Photography"]};
        _animated = NO;
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.headerReferenceSize = CGSizeMake(160, 44);
    layout.minimumInteritemSpacing = 5.0f;
    layout.minimumLineSpacing = 1.0f;
    layout.sectionInset = UIEdgeInsetsMake(7, 7, 7, 7);
    
    _detailTagsViewController = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20-30) collectionViewLayout:layout];
    _detailTagsViewController.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Content-BG.png"]];
    [_detailTagsViewController registerClass:[EduCell class] forCellWithReuseIdentifier:@"EduCell"];
    [_detailTagsViewController registerClass:[TagCell class] forCellWithReuseIdentifier:@"TagCell"];
    [_detailTagsViewController registerClass:[SectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    _detailTagsViewController.delegate = self;
    _detailTagsViewController.dataSource = self;
    
    [self.view addSubview:_detailTagsViewController];
    
    _ornament_top = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ornament-top.png"]];
    _ornament_top.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 20);
    _ornament_top.alpha = 0;
    [self.view addSubview:_ornament_top];
    
    _ornament_bottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ornament-bottom.png"]];
    _ornament_bottom.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - 40);
    _ornament_bottom.alpha = 0;
    [self.view addSubview:_ornament_bottom];
}

- (void)startAnimation
{
    if (!_animated) {
        _animated = YES;
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             _ornament_top.alpha = 1;
             _ornament_bottom.alpha = 1;
         }
                         completion:nil];
    }
}

-(CGSize)getSizeForText:(NSString *)text
{
    CGSize size = [text sizeWithFont:[UIFont fontWithName: @"Avenir-Light" size: 14.0f] constrainedToSize:CGSizeMake(200.0f, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    return size;
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(300, 45);
    }else{
        NSString *text;
        switch (indexPath.section) {
            case 1:
            {
                text = [[_details objectForKey:@"skills"]objectAtIndex:indexPath.row];
            }
                break;
                
            case 2:
            {
                text = [[_details objectForKey:@"interests"]objectAtIndex:indexPath.row];
            }
                break;
                
            default:
                break;
        }
        CGSize size = [self getSizeForText:text];
        size.width = size.width + 10;
        size.height = size.height + 8;
        return size;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return [[_details objectForKey:@"skills"]count];
            break;
            
        case 2:
            return [[_details objectForKey:@"interests"]count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            EduCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EduCell" forIndexPath:indexPath];
            return cell;
        }
            break;
            
        case 1:
        {
            TagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCell" forIndexPath:indexPath];
            [cell setText:[[_details objectForKey:@"skills"]objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
            
        case 2:
        {
            TagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCell" forIndexPath:indexPath];
            [cell setText:[[_details objectForKey:@"interests"]objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            header.title.text = @"Education:";
            break;
            
        case 1:
            header.title.text = @"Skills:";
            break;
            
        case 2:
            header.title.text = @"Interests:";
            break;
            
        default:
            break;
    }
    return header;
}

@end