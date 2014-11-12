//
//  WebRequestHelper.m
//  scriptr
//
//  Created by Andrew Brandt on 11/12/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "WebRequestHelper.h"
#import "AFNetworking/AFNetworking.h"

@interface WebRequestHelper ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation WebRequestHelper

//should not be hardcoded
static NSString* const PLACES_KEY = @"AIzaSyDwEJUX3Eh_RTWAanfQMuiXcxRGmsvxb9U";
static NSString* const API_BASE_URL_STRING = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json";
static WebRequestHelper *singleton;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.sessionManager = [AFHTTPSessionManager new];
    }

    return self;
}

+ (instancetype)sharedHelper {
    if (!singleton) {
        singleton = [WebRequestHelper new];
    }
    return singleton;
}

- (void)getDefaultPharmacyLocations: (CLLocationCoordinate2D)coordinates {
    NSString *locationString = [NSString stringWithFormat:@"%f,%f", coordinates.latitude, coordinates.longitude];
    NSDictionary *params = @{@"key":PLACES_KEY,@"radius":@1000,@"types":@"pharmacy", @"location":locationString};
    
    [self.sessionManager GET:API_BASE_URL_STRING parameters:params
    success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (NSDictionary *)constructParametersFromDictionary: (NSDictionary *)params {
    return params;
}

@end
