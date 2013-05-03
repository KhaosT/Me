//
//  TagCell.h
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCell : UICollectionViewCell

@property (strong,nonatomic) UILabel    *label;

-(void)setText:(NSString *)text;

@end
