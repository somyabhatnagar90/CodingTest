//
//  Constant.h
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#ifndef WeatherApp_Constant_h
#define WeatherApp_Constant_h

// the http URL used for fetching the Weather Forecast Feeds
#define kWeatherForecastURL @"https://api.forecast.io/forecast/%@/%.8f,%.8f"
// the API Key used for fetching the Weather Forecast Feeds
#define kWeatherForecastAPIKey @"341048354f3567dd0f87af2314dd65dc"


#define kCurrently             @"currently"
#define kHourly                @"hourly"
#define kDaily                 @"daily"
#define kData                  @"data"
#define kTemperature           @"temperature"
#define kMinTemp               @"temperatureMin"
#define kMaxTemp               @"temperatureMax"
#define kCloudCover            @"cloudCover"
#define kDewPoint              @"dewPoint"
#define kHumidity              @"humidity"
#define kPressure              @"pressure"
#define kSummary               @"summary"
#define kSunrise               @"sunrise"
#define kSunset                @"sunset"
#define kData                  @"data"
#define kWindSpeed             @"windSpeed"
#define kIcon                  @"icon"
#define kTime                  @"time"
#define kTimeZone              @"timeZone"
#define kCurrently             @"currently"
#define kHourly                @"hourly"
#define kDaily                 @"daily"

typedef NS_ENUM(NSUInteger, ForecastFeedType) {
    WeatherFeedTypeCurrently = 0,
    WeatherFeedTypeHourly,
    WeatherFeedTypeDaily,
    WeatherFeedTypeUnknown,
};

#endif
