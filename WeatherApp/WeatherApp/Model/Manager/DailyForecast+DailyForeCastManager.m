//
//  DailyForecast+DailyForeCastManager.m
//  WeatherApp
//
//  Created by Somya Srivastava on 30/06/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import "DailyForecast+DailyForeCastManager.h"

@implementation DailyForecast (DailyForeCastManager)

+ (DailyForecast *)getForecastWithWeatherAPI:(NSDictionary *)weatherForecastDictionary inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    DailyForecast *dailyForecast = nil;
    dailyForecast = [NSEntityDescription insertNewObjectForEntityForName:@"DailyForecast" inManagedObjectContext:managedObjectContext];
    dailyForecast.temperature = [weatherForecastDictionary objectForKey:@"temperature"];
    dailyForecast.cloudCover = [weatherForecastDictionary objectForKey:@"cloudCover"];
    dailyForecast.dewPoint = [weatherForecastDictionary objectForKey:@"dewPoint"];
    dailyForecast.humidity = [weatherForecastDictionary objectForKey:@"humidity"];
    dailyForecast.pressure = [weatherForecastDictionary objectForKey:@"pressure"];
    dailyForecast.summary = [weatherForecastDictionary objectForKey:@"summary"];
    dailyForecast.sunrise = [weatherForecastDictionary objectForKey:@"sunrise"];
    dailyForecast.sunset = [weatherForecastDictionary objectForKey:@"sunset"];
    dailyForecast.windSpeed = [weatherForecastDictionary objectForKey:@"windSpeed"];
    dailyForecast.icon = [weatherForecastDictionary objectForKey:@"icon"];
    dailyForecast.visibility = [weatherForecastDictionary objectForKey:@"visibility"];
    dailyForecast.time = [weatherForecastDictionary objectForKey:@"time"];
        
    return dailyForecast;
}

@end
