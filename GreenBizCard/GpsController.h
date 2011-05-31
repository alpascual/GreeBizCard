//
//  GpsController.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "GpsDelegateProtocol.h"


@interface GpsController : NSObject <CLLocationManagerDelegate> {
    
    CLLocationManager *locationManager;
    
    id <GpsDelegateProtocol> gpsDelegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager; 
@property (retain, nonatomic) id <GpsDelegateProtocol> gpsDelegate;


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

- (void) start;
- (void) stop;

@end
