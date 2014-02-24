//
//  ViewController.h
//  Peekme
//
//  Created by Juan on 22/02/14.
//  Copyright (c) 2014 JSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

// Explore btn
- (IBAction)btnExplore;

// Lat & long vars
@property NSString *latitude;
@property NSString *longitude;

@end
