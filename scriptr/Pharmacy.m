//
//  Pharmacy.m
//  scriptr
//
//  Created by Andrew Brandt on 11/12/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "Pharmacy.h"
#import "AppDelegate.h"

@implementation Pharmacy

@dynamic pharmacyName;
@dynamic pharmacyAddress;
@dynamic pharmacyLongitude;
@dynamic pharmacyLatitude;

+ (instancetype)createPharmacyFromContext:(NSManagedObjectContext *)context {
    Pharmacy *pharmacy = [NSEntityDescription insertNewObjectForEntityForName:@"Pharmacy" inManagedObjectContext:context];
    return pharmacy;
}

@end
