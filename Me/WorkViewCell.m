//
//  WorkViewCell.m
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "WorkViewCell.h"

#import <QuartzCore/QuartzCore.h>

@implementation WorkViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 57, 57)];
        self.icon.layer.shadowOffset = CGSizeMake(0, 0.5);
        self.icon.layer.shadowOpacity = 0.8;
        self.icon.layer.shadowRadius = 1.0f;
        self.icon.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        [self.contentView addSubview:self.icon];
        
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        self.name.backgroundColor = [UIColor clearColor];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.font = [UIFont fontWithName: @"Avenir-Light" size: 14.0f];
        self.name.textColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
        [self.contentView addSubview:self.name];
        
        self.actView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.actView.center = self.icon.center;
        [self.contentView addSubview:self.actView];
        // Initialization code
    }
    return self;
}

- (void)setCellWithName:(NSString *)name Icon:(UIImage *)icon
{
    CGSize size = [name sizeWithFont:[UIFont fontWithName: @"Avenir-Light" size: 14.0f] constrainedToSize:CGSizeMake(200.0f, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    self.name.frame = CGRectMake(0, 0, size.width, size.height);
    self.name.text = name;
    self.name.center = CGPointMake(self.icon.center.x, self.icon.center.y+40);
    
    self.icon.image = icon;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}*/


@end
