//
//  CustomTableViewCell.h
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyForecast.h"

@interface CustomTableViewCell : UITableViewCell

- (void)configureCell;
- (void)setLabelValueFor:(DailyForecast*)item;

- (void)summaryLabelStyle:(UILabel*)headlineLabel;
- (void)otherLabelStyle:(NSArray*)otherLabels;

@end
