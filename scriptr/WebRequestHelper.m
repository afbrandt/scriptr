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

- (void)getDefaultPharmacyLocations: (CLLocationCoordinate2D)coordinates withBlock:(void (^)(NSArray *))complete {
    NSDictionary *params = [self buildDefaultParametersWithLocation:coordinates];
    
    [self.sessionManager GET:API_BASE_URL_STRING parameters:params
    success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSError *error;
        //NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        //NSLog(@"%@", responseObject);
        NSArray *locations = responseObject[@"results"];
        NSLog(@"%lu", (unsigned long)[locations count]);
        complete(locations);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (void)getPharmacyLocations: (CLLocationCoordinate2D)coordinates withKeyword: (NSString *)keyword withBlock:(void (^)(NSArray *))complete {
    NSMutableDictionary *params = [[self buildDefaultParametersWithLocation:coordinates] mutableCopy];
    params[@"radius"] = @2000;
    params[@"keyword"] = keyword;
    //params[@"rankby"] = @"distance";
    
    [self.sessionManager GET:API_BASE_URL_STRING parameters:params
    success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *locations = responseObject[@"results"];
        complete(locations);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (NSDictionary *)buildDefaultParametersWithLocation: (CLLocationCoordinate2D)location {
    NSString *locationString = [NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude];
    NSDictionary *params = @{@"key":PLACES_KEY,@"radius":@1000,@"types":@"pharmacy", @"location":locationString};
    return params;
}

@end
