//
//  DailyForecast.h
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyForecast : NSObject

@property (nonatomic, retain) NSString * temperatureMin;
@property (nonatomic, retain) NSString *temperatureMax;
@property (nonatomic, retain) NSString *temperature;
@property (nonatomic, retain) NSString * cloudCover;
@property (nonatomic, retain) NSString * dewPoint;
@property (nonatomic, retain) NSString * humidity;
@property (nonatomic, retain) NSString * pressure;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * data;
@property (nonatomic, retain) NSString * windSpeed;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString *currently;
@property (nonatomic, retain) NSString *hourly;
@property (nonatomic, retain) NSString *daily;

@end
