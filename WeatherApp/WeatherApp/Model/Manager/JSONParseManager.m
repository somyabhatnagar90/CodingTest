//
//  JSONParseManager.m
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import "JSONParseManager.h"
#import "Constant.h"
#import "DailyForecast.h"

@implementation JSONParseManager

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self != nil)
    {
        _dataToParse = data;
    }
    return self;
}

- (void)main
{
    if (![self isCancelled])
    {
        NSError *error;
        // Parsing the JSON data received from web service into an NSDictionary object
        NSDictionary *responseDictinary = [NSJSONSerialization JSONObjectWithData: self.dataToParse
                                                                          options: NSJSONReadingMutableContainers
                                                                            error: &error];
        
        
        _weatherDataList = [[NSMutableDictionary alloc] init];
        
        if (responseDictinary != nil)
        {
            //Parsing Hourly Weather Forcast Data
            NSDictionary *currentlyDictionary = responseDictinary[kCurrently];
            NSMutableArray *currentDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            if (currentlyDictionary != nil)
            {
                DailyForecast *item = [[DailyForecast alloc] init];
                item.time = [self getDate:[currentlyDictionary[kTime] doubleValue]];
                item.summary = currentlyDictionary[kSummary];
                item.icon = currentlyDictionary[kIcon];
                item.temperature = currentlyDictionary[kTemperature];
                item.dewPoint = currentlyDictionary[kDewPoint];
                item.humidity = currentlyDictionary[kHumidity];
                item.windSpeed = currentlyDictionary[kWindSpeed];

                item.cloudCover = currentlyDictionary[kCloudCover];
                item.pressure = currentlyDictionary[kPressure];
                
                [currentDataArray addObject:item];
            }
            
            // Set Forecast Item to the List
            self.weatherDataList[kCurrently] = currentDataArray;
            
            //Parsing Hourly Weather Forcast Data
            NSDictionary *hourlyDictionary = responseDictinary[kHourly];
            NSMutableArray *hourlyDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            if (hourlyDictionary != nil)
            {
                NSArray * hourlyDataList = hourlyDictionary[kData];
                for (NSDictionary *dataObject in hourlyDataList)
                {
                    DailyForecast *item = [[DailyForecast alloc] init];
                    item.time = [self getDate:[dataObject[kTime] doubleValue]];
                    item.summary = dataObject[kSummary];
                    item.icon = dataObject[kIcon];
                    item.temperature = dataObject[kTemperature];
                    item.dewPoint = dataObject[kDewPoint];
                    item.humidity = dataObject[kHumidity];
                    item.windSpeed = dataObject[kWindSpeed];
                    item.cloudCover = dataObject[kCloudCover];
                    item.pressure = dataObject[kPressure];
                    
                    [hourlyDataArray addObject:item];
                }
            }
            
            // Set Forecast Item to the List
            self.weatherDataList[kHourly] = hourlyDataArray;
            
            //Parsing Daily Weather Forcast Data
            NSDictionary *dailyDictionary = responseDictinary[kDaily];
            NSMutableArray *dailyDataArray = [[NSMutableArray alloc] initWithCapacity:0];
            if (dailyDictionary != nil)
            {
                NSArray * dailyDataList = dailyDictionary[kData];
                for (NSDictionary *dataObject in dailyDataList)
                {
                    DailyForecast *item = [[DailyForecast alloc] init];
                    item.time = [self getDate:[dataObject[kTime] doubleValue]];
                    item.summary = dataObject[kSummary];
                    item.icon = dataObject[kIcon];
                    item.temperatureMin = dataObject[kMinTemp];
                    item.temperatureMax = dataObject[kMaxTemp];
                    item.dewPoint = dataObject[kDewPoint];
                    item.humidity = dataObject[kHumidity];
                    item.windSpeed = dataObject[kWindSpeed];
                    item.cloudCover = dataObject[kCloudCover];
                    item.pressure = dataObject[kPressure];
                    
                    [dailyDataArray addObject:item];
                }
            }
            
            // Set Forecast Item to the List
            self.weatherDataList[kDaily] = dailyDataArray;
        }
    }
    self.dataToParse = nil;
}

-(NSString*)getDate:(double)value
{
    double timestampval =  value;
    NSTimeInterval timestamp = (NSTimeInterval)timestampval;
    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy hh:mm:ss"];
    
    NSString *stringFromDate = [formatter stringFromDate:updatetimestamp];
    return stringFromDate;
}

@end
