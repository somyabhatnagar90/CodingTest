//
//  LocationManager.h
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, atomic) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;

+(LocationManager*)sharedManager;

@end
