//
//  TagCell.m
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell{
    UIImageView     *_background;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _background = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"tag-bg"]resizableImageWithCapInsets:UIEdgeInsetsMake(13, 10, 13, 10)]];
        [self.contentView addSubview:_background];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont fontWithName: @"Avenir-Light" size: 14.0f];
        _label.textColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
        
        [self.contentView addSubview:_label];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    CGSize size = [text sizeWithFont:[UIFont fontWithName: @"Avenir-Light" size: 14.0f] constrainedToSize:CGSizeMake(200.0f, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    _background.frame = CGRectMake(0, 0, size.width + 10, size.height+5);
    _label.frame = CGRectMake(5, 3, size.width, size.height);
    _label.text = text;
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
