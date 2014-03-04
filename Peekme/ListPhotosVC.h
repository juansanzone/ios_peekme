//
//  ListPhotosVC.h
//  Peekme
//
//  Created by Juan on 27/02/14.
//  Copyright (c) 2014 JSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ListPhotosVC : UIViewController  <CLLocationManagerDelegate>

// Lat & long vars
@property NSString *latitude;
@property NSString *longitude;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *getLocationIndicator;

@property (weak, nonatomic) IBOutlet UILabel *getLocationLabel;

- (IBAction)updateLocationButton:(UIBarButtonItem *)sender;

@end
