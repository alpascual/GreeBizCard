//
//  GpsController.m
//  GreenBizCard
//
//  Created by Albert Pascual on 3/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "GpsController.h"


@implementation GpsController

@synthesize gpsDelegate, locationManager;

- (void) start
{	
	
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.distanceFilter = 25;
    
    self.locationManager.delegate = self; // send loc updates to myself
    
	//self.noiseMaker = noise;
	[self.locationManager startUpdatingLocation];
	
	
}

- (void) stop
{
	[self.locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);	
	
	/*if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) &&
		(oldLocation.coordinate.longitude != newLocation.coordinate.longitude))
	{		
		// Start going nuts
		NSLog(@"Alarm going with old location: %@", [oldLocation description]);	
	}	
	else
	{
		NSLog(@"Relax hasn't moved: %@", [oldLocation description]);	
	}*/
    
    // Use delegate here to give your the lat and long
    
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString *longitude = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
	
    [gpsDelegate gpsFinished:latitude :longitude];
    
    [latitude release];
    [longitude release];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}


@end
