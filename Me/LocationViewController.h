//
//  LocationViewController.h
//  Me
//
//  Created by Khaos Tian on 4/29/13.
//  Copyright (c) 2013 Oltica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationViewController : UIViewController<MKMapViewDelegate>

- (void)didScrollToTheView;

@end
