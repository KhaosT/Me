//
//  EduCell.m
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import "EduCell.h"

@implementation EduCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* strokeColor = [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    
    //// Image Declarations
    UIImage* image140gradhat = [UIImage imageNamed: @"image140gradhat"];
    UIColor* image140gradhatPattern = [UIColor colorWithPatternImage: image140gradhat];
    
    //// Abstracted Attributes
    NSString* textContent = @"Shenzhen Senior High School";
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(37, 2, 254, 37);
    [strokeColor setFill];
    [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Avenir-Light" size: [UIFont buttonFontSize]] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    
    //// Image 140-gradhat 2 Drawing
    UIBezierPath* image140gradhat2Path = [UIBezierPath bezierPathWithRect: CGRectMake(7, 2, 30, 23)];
    CGContextSaveGState(context);
    CGContextSetPatternPhase(context, CGSizeMake(7, 2));
    [image140gradhatPattern setFill];
    [image140gradhat2Path fill];
    CGContextRestoreGState(context);
}

@end
