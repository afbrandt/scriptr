//
//  WebRequestHelper.h
//  scriptr
//
//  Created by Andrew Brandt on 11/12/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface WebRequestHelper : NSObject

- (void)getDefaultPharmacyLocations: (CLLocationCoordinate2D)coordinates withBlock:(void (^)(NSArray *))completionBlock;
- (void)getPharmacyLocations: (CLLocationCoordinate2D)coordinates withKeyword: (NSString *)keyword withBlock:(void (^)(NSArray *))completionBlock;

+ (instancetype)sharedHelper;

@end
