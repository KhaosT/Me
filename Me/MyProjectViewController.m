//
//  MyProjectViewController.m
//  Me
//
//  Created by Khaos Tian on 4/28/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "MyProjectViewController.h"
#import "WorkViewCell.h"
#import "ProjectHeader.h"
#import "InfoViewController.h"

#import <StoreKit/StoreKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MyProjectViewController (){
    UICollectionView    *_worksCollectionView;
    
    NSDictionary        *_projects;
    
    BOOL                _pendingLoading;
}

@end

@implementation MyProjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _pendingLoading = NO;
        _projects = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Projects" ofType:@"plist"]];
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*3, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Content-BG.png"]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 90);
    layout.headerReferenceSize = CGSizeMake(320, 44);
    layout.minimumInteritemSpacing = 1.0f;
    layout.minimumLineSpacing = 5.0f;
    layout.sectionInset = UIEdgeInsetsMake(7, 7, 7, 7);
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 28);
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName: @"Avenir-Light" size: 28.0f];
    title.textColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    title.text = @"Projects";
    
    [self.view addSubview:title];
    
    UIImageView *ornmaent_left = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 44)];
    [ornmaent_left setImage:[UIImage imageNamed:@"ornament-left.png"]];
    ornmaent_left.center = CGPointMake(title.center.x-70, title.center.y);
    [self.view addSubview:ornmaent_left];
    
    UIImageView *ornmaent_right = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 44)];
    [ornmaent_right setImage:[UIImage imageNamed:@"ornament-right.png"]];
    ornmaent_right.center = CGPointMake(title.center.x+70, title.center.y);
    [self.view addSubview:ornmaent_right];
    
    _worksCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20-50) collectionViewLayout:layout];
    _worksCollectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Content-BG.png"]];
    [_worksCollectionView registerClass:[WorkViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [_worksCollectionView registerClass:[ProjectHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    _worksCollectionView.delegate = self;
    _worksCollectionView.dataSource = self;
    
    [self.view addSubview:_worksCollectionView];
    
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

#pragma mark CollectionViewDataSource&Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [[_projects objectForKey:@"software"]count];
            break;
            
        case 1:
            return [[_projects objectForKey:@"hardware"]count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WorkViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            [cell setCellWithName:[[[_projects objectForKey:@"software"]objectAtIndex:indexPath.row]objectForKey:@"name"] Icon:[UIImage imageNamed:[[[_projects objectForKey:@"software"]objectAtIndex:indexPath.row]objectForKey:@"icon"]]];
        }
            break;
            
        case 1:
            [cell setCellWithName:[[[_projects objectForKey:@"hardware"]objectAtIndex:indexPath.row]objectForKey:@"name"] Icon:[UIImage imageNamed:[[[_projects objectForKey:@"hardware"]objectAtIndex:indexPath.row]objectForKey:@"icon"]]];
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ProjectHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            header.title.text = @"Software";
            break;
            
        case 1:
            header.title.text = @"Hardware";
            break;
            
        default:
            break;
    }
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WorkViewCell *cell = (WorkViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (!_pendingLoading) {
            _pendingLoading = YES;
            [cell.actView startAnimating];
            SKStoreProductViewController *storeViewController =
            [[SKStoreProductViewController alloc] init];
            
            storeViewController.delegate = self;
            
            NSDictionary *parameters =
            @{SKStoreProductParameterITunesItemIdentifier:
                  [NSNumber numberWithInteger:[[[[_projects objectForKey:@"software"]objectAtIndex:indexPath.row]objectForKey:@"appID"]integerValue]]};
            
            [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error) {
                if (result) {
                    [cell.actView stopAnimating];
                    _pendingLoading = NO;
                    [self presentViewController:storeViewController animated:YES completion:nil];
                }else{
                    NSLog(@"Err:%@",error);
                }
            }];
        }
    }else{
        InfoViewController *info = [[InfoViewController alloc]initWithNibName:nil bundle:nil];
        info.infoDict = [[_projects objectForKey:@"hardware"]objectAtIndex:indexPath.row];
        info.contentController = self;
        [self presentViewController:info animated:YES completion:nil];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - StoreDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
