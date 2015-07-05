//
//  ViewController.m
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import "ViewController.h"
#import "DailyForecast.h"
#import "JSONParseManager.h"
#import "CustomCurrentTableViewCell.h"
#import "CustomHourTableViewCell.h"
#import "CustomDailyTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController {
    
    NSString *latitude;
    NSString *longitude;
    NSString *weatherString;
}

@synthesize locationManager = _locationManager;
@synthesize currentLocation = _currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.weatherTableView.delegate = self;
    self.weatherTableView.dataSource = self;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationObject = [LocationManager sharedManager];
        [self.locationObject.locationManager requestAlwaysAuthorization];
        [self.locationObject.locationManager startUpdatingLocation];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(getLocation:) name:@"locationNotification" object:nil];
    }
    else
    {
        NSString *title = @"Location services are off";
        NSString *message = @"To use location you must turn on 'Always' in the Location Services Settings.";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = self.segmentedControl.selectedSegmentIndex;
    
    switch (index)
    {
        case 0:
        {
            self.feedType = WeatherFeedTypeCurrently;
            return [self.forecastEntries[kCurrently] count];
            break;
        }
        case 1:
        {
            self.feedType = WeatherFeedTypeDaily;
            return [self.forecastEntries[kDaily] count];
            break;
        }
        case 2:
        {
            self.feedType = WeatherFeedTypeHourly;
            return [self.forecastEntries[kHourly] count];
            break;
        }
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = self.segmentedControl.selectedSegmentIndex;
    
    switch (index)
    {
        case WeatherFeedTypeCurrently:
        {
            return 320;
            break;
        }
        case WeatherFeedTypeHourly:
        {
            return 320;
            break;
        }
        case WeatherFeedTypeDaily:
        {
            return 320;
            break;
        }
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCurrentTableViewCell *currentlyCell = nil;
    CustomHourTableViewCell *hourlyCell = nil;
    CustomDailyTableViewCell *dailyCell = nil;
    
    DailyForecast *item;
    
    switch (self.feedType)
    {
        case WeatherFeedTypeCurrently:
        {
            currentlyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomCurrentTableViewCell class]) forIndexPath:indexPath];
            
            if(currentlyCell == nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle]loadNibNamed:
                                      NSStringFromClass([CustomCurrentTableViewCell class]) owner:self options:nil];
                currentlyCell = [cellArray objectAtIndex:0];
            }
            item = (DailyForecast *)self.forecastEntries[kCurrently][indexPath.row];
            [currentlyCell configureCell];
            [currentlyCell setLabelValueFor:item];
            return currentlyCell;
            break;
        }
        case WeatherFeedTypeHourly:
        {
            hourlyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomHourTableViewCell class]) forIndexPath:indexPath];
            
            if(hourlyCell == nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle]loadNibNamed:
                                      NSStringFromClass([CustomHourTableViewCell class]) owner:self options:nil];
                hourlyCell = [cellArray objectAtIndex:0];
            }
            
            item = (DailyForecast *)self.forecastEntries[kHourly][indexPath.row];
            [hourlyCell configureCell];
            [hourlyCell setLabelValueFor:item];
            
            return hourlyCell;
            break;
        }
        case WeatherFeedTypeDaily:
        {
            dailyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomDailyTableViewCell class]) forIndexPath:indexPath];
            
            if(dailyCell == nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle]loadNibNamed:
                                      NSStringFromClass([CustomDailyTableViewCell class]) owner:self options:nil];
                dailyCell = [cellArray objectAtIndex:0];
            }
            
            item = (DailyForecast *)self.forecastEntries[kDaily][indexPath.row];
            [dailyCell configureCell];
            [dailyCell setLabelValueFor:item];
            
            return dailyCell;
            break;
        }
        default:
            break;
    }
    
    return  nil;
}

- (IBAction)forecastOptionChanged:(id)sender
{
    [self.weatherTableView reloadData];
}

#pragma mark - Get Current Location (Lat, Lng)
-(void)getLocation:(NSNotification*)notification
{
    NSString *weatherURL = [NSString stringWithFormat:kWeatherForecastURL,kWeatherForecastAPIKey, self.locationObject.location.coordinate.latitude,self.locationObject.location.coordinate.longitude];
    [self getWeatherFeedFromUrl:weatherURL];
}

#pragma mark - NSURLConnection Request
-(void)getWeatherFeedFromUrl:(NSString*)url
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.forecastConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];

    
    NSAssert(self.forecastConnection != nil, @"Failure to create URL connection.");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark - NSURLConnection Error handler

- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Displaying Feed"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.forecastListData = [NSMutableData data];    // start off with new data
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.forecastListData appendData:data];  // append incoming data
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (error.code == kCFURLErrorNotConnectedToInternet)
    {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"No Connection Error"};
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        [self handleError:noConnectionError];
    }
    else
    {
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    self.forecastConnection = nil;   // release our connection
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.forecastConnection = nil;   // release our connection
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // create the queue to run our ParseOperation
    self.queue = [[NSOperationQueue alloc] init];
    
    // create an JSONParseOperation (NSOperation subclass) to parse the Weather Forecast feed data
    // so that the UI is not blocked
    JSONParseManager *parser = [[JSONParseManager alloc] initWithData:self.forecastListData];
    
    parser.errorHandler = ^(NSError *parseError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleError:parseError];
        });
    };
    
    __strong JSONParseManager *weakParser = parser;
    
    parser.completionBlock = ^(void) {
        if (weakParser.weatherDataList) {
            // The completion block may execute on any thread.  Because operations
            // involving the UI are about to be performed, make sure they execute
            // on the main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.forecastEntries = [weakParser.weatherDataList copy];
                
                // tell our table view to reload its data, now that parsing has completed
                [self.weatherTableView reloadData];
            });
        }
        
        // we are finished with the queue and our ParseOperation
        self.queue = nil;
    };
    
    [self.queue addOperation:parser]; // this will start the "ParseOperation"
    
    // ownership of appListData has been transferred to the parse operation
    // and should no longer be referenced in this thread
    self.forecastListData = nil;
}

@end
