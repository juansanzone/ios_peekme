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

// Lat & long vars
@property NSString *latitude;
@property NSString *longitude;

// Explore now Btn
- (IBAction)btnExplore;

- (IBAction)btnTellAFriend;

- (IBAction)btnExploreTouchDown:(UIButton *)sender;

- (IBAction)btnExploreTouchUpOut:(UIButton *)sender;

@end
