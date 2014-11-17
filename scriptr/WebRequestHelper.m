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
static NSString* const PLACE_API_BASE_URL_STRING = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json";
static NSString* const REV_GEOCODE_API_BASE_URL_STRING = @"https://maps.googleapis.com/maps/api/geocode/json";
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
    NSDictionary *params = [self buildDefaultPharmacyParametersWithLocation:coordinates];
    
    [self.sessionManager GET:PLACE_API_BASE_URL_STRING parameters:params
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
    NSMutableDictionary *params = [[self buildDefaultPharmacyParametersWithLocation:coordinates] mutableCopy];
    params[@"radius"] = @2000;
    params[@"keyword"] = keyword;
    //params[@"rankby"] = @"distance";
    
    [self.sessionManager GET:PLACE_API_BASE_URL_STRING parameters:params
    success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *locations = responseObject[@"results"];
        complete(locations);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (void)getDefaultDropOffLocation:(CLLocationCoordinate2D)coordinates withBlock:(void (^)(NSArray *))completionBlock {
    NSString *location = [self buildCoordinateString:coordinates];
    NSDictionary *params = @{@"key":PLACES_KEY, @"latlng":location, @"result_type":@"street_address"};
    [self.sessionManager GET:REV_GEOCODE_API_BASE_URL_STRING parameters:params
    success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *locations = responseObject[@"results"];
        completionBlock(locations);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (void)getDropOffLocations:(CLLocationCoordinate2D)coordinates withKeyword:(NSString *)keyword withBlock:(void (^)(NSArray *))completionBlock {

}

- (NSDictionary *)buildDefaultPharmacyParametersWithLocation: (CLLocationCoordinate2D)location {
    NSString *locationString = [self buildCoordinateString:location];
    NSDictionary *params = @{@"key":PLACES_KEY,@"radius":@1000,@"types":@"pharmacy", @"location":locationString};
    return params;
}

- (NSString *)buildCoordinateString: (CLLocationCoordinate2D)coordinate {
    return [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
}

- (void)postNewOrder:(Order *)order withBlock:(void (^)(void))completionBlock {

}


@end
