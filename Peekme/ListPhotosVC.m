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




-(void) callToWsAction
{
    NSLog(@"Create and init Request to WS");
    
    // Create request
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://datta.zendelsolutions.com/sanzone/?debug"]];
    
    // Connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.getLocationLabel.text = @"Fetching photos";
    [self.getLocationIndicator startAnimating];
}

-(void) finishCallToWsAction
{
    self.getLocationLabel.text = @"Get Photos OK!";
    [self.getLocationIndicator stopAnimating];
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
    //[NSThread sleepForTimeInterval:1.0f];
    
    self.getLocationLabel.text = @"";
    [self.getLocationIndicator stopAnimating];
    
    NSLog(@"Latitude nueva: %@", self.latitude);
    NSLog(@"Longitude nueva: %@", self.longitude);
    
    [self callToWsAction];
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




/* -------  NSURLConnection Delegate Methods  ------- */

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // Alloc init to response data
    self._responseData = [[NSMutableData alloc] init];
    NSLog(@"Receive response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Receive data and save to response data var
    NSLog(@"Receive data");
    [self._responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Finish load, parse data
    NSLog(@"Finished, get data OK!");
    
    [self finishCallToWsAction];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Request failed
    NSLog(@"Error to get data from WS: %@", error);
}

/* -------  END - NSURLConnection Delegate Methods  ------- */




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
/* ------- END - locationManager EVENTS ------- */
@end
