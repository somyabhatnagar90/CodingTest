//
//  ViewController.h
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
#import <CoreLocation/CoreLocation.h>
#import "Constant.h"
#import "LocationManager.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITableViewDataSource,UITableViewDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;
@property (strong, nonatomic) LocationManager *locationObject;
@property (nonatomic) ForecastFeedType feedType;

// the queue to run our "ParseOperation"
@property (nonatomic, strong) NSOperationQueue *queue;
// Network connection to the Weather Forecast URL
@property (nonatomic, strong) NSURLConnection *forecastConnection;
@property (nonatomic, strong) NSMutableData *forecastListData;
@property (nonatomic, strong) NSDictionary *forecastEntries;

@end

