//
//  ProjectHeader.m
//  Me
//
//  Created by Khaos Tian on 4/30/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "ProjectHeader.h"

@implementation ProjectHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.title = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-45, 0, 90, 44)];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
        self.title.font = [UIFont fontWithName: @"Avenir-Light" size: 24];
        self.title.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.title];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
