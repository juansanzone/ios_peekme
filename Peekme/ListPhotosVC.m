//
//  ListPhotosVC.m
//  Peekme
//
//  Created by Juan on 27/02/14.
//  Copyright (c) 2014 JSoft. All rights reserved.
//

#import "ListPhotosVC.h"

@interface ListPhotosVC ()

@end

@implementation ListPhotosVC

// Declare locationManager
CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // SystemStatusBar TintColor Fix
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Init locationManager
    locationManager = [[CLLocationManager alloc] init];
    
    [self callToLocationManagerAction];
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)callToLocationManagerAction
{
    self.getLocationLabel.text = @"Getting location";
    [self.getLocationIndicator startAnimating];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

-(void)finishLocationManagerAction
{
    [NSThread sleepForTimeInterval:1.0f];
    
    self.getLocationLabel.text = @"";
    [self.getLocationIndicator stopAnimating];
    
    NSLog(@"Latitude nueva: %@", self.latitude);
    NSLog(@"Longitude nueva: %@", self.longitude);
}

-(void)failedLocationManagerAction
{
    self.getLocationLabel.text = @"Failed to Get Your Location";
    [self.getLocationIndicator stopAnimating];
}

- (IBAction)updateLocationButton:(UIBarButtonItem *)sender
{
    [self callToLocationManagerAction];
}


// SystemStatusBar TintColor Fix
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

/* ------- locationManager EVENTS ------- */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    [self failedLocationManagerAction];
    
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (nil != currentLocation)
    {
        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        // Stop locationManager (SavingBatteryPower)
        [locationManager stopUpdatingLocation];
        
        [self finishLocationManagerAction];
    }
}
/* ------- END locationManager EVENTS ------- */
@end
