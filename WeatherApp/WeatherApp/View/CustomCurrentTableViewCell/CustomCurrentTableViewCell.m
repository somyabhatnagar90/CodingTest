//
//  CustomCurrentTableViewCell.m
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import "CustomCurrentTableViewCell.h"

@implementation CustomCurrentTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configureCell
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self summaryLabelStyle:self.summary];
    
    NSArray *allLabels = [[NSArray alloc] initWithObjects:self.time, self.temperature, self.dewPoint, self.humidity, self.windSpeed, self.cloudCover,self.pressure, nil];
    
    [self otherLabelStyle:allLabels];
}

-(void)setLabelValueFor:(DailyForecast*)item
{
    self.time.text = [item.time description];
    self.summary.text = [item.summary description];
    self.summary.numberOfLines = 2;
    self.icon.image = [UIImage imageNamed:[item.icon description]];
    self.temperature.text = [NSString stringWithFormat:@"%@ ºF",[item.temperature description]];
    self.dewPoint.text = [item.dewPoint description];
    self.humidity.text = [item.humidity description];
    self.windSpeed.text = [item.windSpeed description];
    self.cloudCover.text = [item.cloudCover description];
    self.pressure.text = [item.pressure description];
}

@end
