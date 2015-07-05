//
//  DailyForecast+DailyForeCastManager.h
//  WeatherApp
//
//  Created by Somya Srivastava on 30/06/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import "DailyForecast.h"

@interface DailyForecast (DailyForeCastManager)

+(DailyForecast *)getForecastWithWeatherAPI:(NSDictionary *)weatherForecastDictionary inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
