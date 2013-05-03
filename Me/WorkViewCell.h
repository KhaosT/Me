//
//  WorkViewCell.h
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView                *icon;
@property (nonatomic,strong) UILabel                    *name;
@property (nonatomic,strong) UIActivityIndicatorView    *actView;

- (void)setCellWithName:(NSString *)name Icon:(UIImage *)icon;

@end
