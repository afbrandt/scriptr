//
//  Pharmacy.h
//  scriptr
//
//  Created by Andrew Brandt on 11/12/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pharmacy : NSManagedObject

@property (nonatomic, retain) NSString * pharmacyName;
@property (nonatomic, retain) NSString * pharmacyAddress;
@property (nonatomic, retain) NSNumber * pharmacyLongitude;
@property (nonatomic, retain) NSNumber * pharmacyLatitude;

+ (instancetype)createPharmacyFromContext: (NSManagedObjectContext *)context;

@end
