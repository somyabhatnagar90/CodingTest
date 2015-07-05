//
//  Forecast.h
//  WeatherApp
//
//  Created by Somya Srivastava on 1/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DailyForecast;

@interface Forecast : NSManagedObject

@property (nonatomic, retain) NSDate * getDate;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) DailyForecast *hasForecast;

@end
