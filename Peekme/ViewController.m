//
//  ViewController.m
//  Peekme
//
//  Created by Juan on 22/02/14.
//  Copyright (c) 2014 JSoft. All rights reserved.
//

#import "ViewController.h"
#import "ListPhotosVC.h"


@interface ViewController ()

@end

@implementation ViewController

// Declare locationManager
CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // SystemStatusBar TintColor Fix
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Init locationManager
    locationManager = [[CLLocationManager alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Hide navigationBar
    self.navigationController.navigationBarHidden = YES;
    
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
   
    /*
        // MANUAL SEGUE
        [self performSegueWithIdentifier:@"showListPhotos" sender:nil];
    */
     
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}


- (IBAction)btnTellAFriend {
    // TODO: Implement share app code
}

/* ------- styles effects for btnExplore ------- */
- (IBAction)btnExploreTouchDown:(UIButton *)sender {
    [sender setAlpha: 0.50];
}

- (IBAction)btnExploreTouchUpOut:(UIButton *)sender {
      [sender setAlpha: 0.25];
}
/* ------- END styles effects for btnExplore ------- */



// SystemStatusBar TintColor Fix
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
    CLLocation *currentLocation = newLocation;
    
    if (nil != currentLocation)
    {
        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        // Stop locationManager (SavingBatteryPower)
        [locationManager stopUpdatingLocation];
        
        NSLog(@"latitude initial screen: %@", self.latitude);
    }
}
/* ------- END locationManager EVENTS ------- */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showListPhotos"]) {
        ListPhotosVC *destViewController = segue.destinationViewController;
        destViewController.latitude = self.latitude;
        destViewController.longitude = self.longitude;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"latitude initial screen segue action: %@", self.latitude);
    
    if ([identifier isEqualToString:@"showListPhotos"]) {
        if ([self.latitude isEqual:[NSNull null]]) {
            NSLog(@"Latitude is null, cancel segue");
            return NO;
        }
    }
    
    return YES;
}

@end
