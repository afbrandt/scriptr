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

- (void)getDefaultPharmacyLocations: (CLLocationCoordinate2D)coordinates;

+ (instancetype)sharedHelper;

@end
