//
//  JSONParseManager.h
//  WeatherApp
//
//  Created by Somya Srivastava on 5/07/2015.
//  Copyright (c) 2015 Somya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParseManager : NSOperation

@property (nonatomic, copy) void (^errorHandler)(NSError *error);
@property (nonatomic, strong, readonly) NSMutableDictionary *weatherDataList;

@property (nonatomic, strong) NSData *dataToParse;

- (instancetype)initWithData:(NSData *)data;

@end
