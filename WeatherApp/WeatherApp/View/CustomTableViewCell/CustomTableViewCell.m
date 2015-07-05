//
//  CustomTableViewCell.m
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)summaryLabelStyle:(UILabel *)headlineLabel {
    UIFont* boldFont = [UIFont boldSystemFontOfSize:20.0];
    headlineLabel.font = boldFont;
    headlineLabel.numberOfLines = 2;
}

- (void)otherLabelStyle:(NSArray *)otherLabels {
    UIFont* arialFont = [UIFont fontWithName:@"Arial" size:15];
    for (UILabel* label in otherLabels)
    {
        if ([label isKindOfClass:[UILabel class]]) {
            label.font = arialFont;
            label.numberOfLines = 1;
        }
        
    }
}

-(void)configureCell
{
    
}

-(void)setLabelValueFor:(DailyForecast*)item
{
    
}

@end
