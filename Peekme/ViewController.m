//
//  ViewController.m
//  Peekme
//
//  Created by Juan on 22/02/14.
//  Copyright (c) 2014 JSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// Declare locationManager
CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Init locationManager
    locationManager = [[CLLocationManager alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Explore button - click action
- (IBAction)btnExplore
{
    // Delegate locationManager
    NSLog(@"Delegate event to locatioManager");
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}


/* ------- locationManager EVENTS ------- */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (nil != currentLocation)
    {
        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        // Stop locationManager (SavingBatteryPower)
        [locationManager stopUpdatingLocation];
        
        // Log values
        NSLog(@"Latitude: %@", self.latitude);
        NSLog(@"Longitude: %@", self.longitude);
        
        // Get reference for Next View
        UIView *viewPhotoList = [self.view viewWithTag:(10)];
        
        // Get references for labels
        UILabel *lblLatitude = (UILabel *)[viewPhotoList viewWithTag:(1)];
        UILabel *lblLongitude = (UILabel *)[viewPhotoList viewWithTag:(2)];
        
        // Send values to Next View
        lblLatitude.text = self.latitude;
        lblLongitude.text = self.longitude;
        
    }
}
/* ------- END locationManager EVENTS ------- */

@end
