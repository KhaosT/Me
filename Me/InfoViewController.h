//
//  InfoViewController.h
//  Me
//
//  Created by Khaos Tian on 4/30/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (nonatomic, strong) NSDictionary *infoDict;
@property (assign, readwrite) id   contentController;
@property (nonatomic, strong) UIScrollView *photoScrollView;

@end
