//
//  Order.h
//  scriptr
//
//  Created by Andrew Brandt on 11/16/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DropOff, Patient, Pharmacy;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSString * orderId;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) DropOff *dropOffLocation;
@property (nonatomic, retain) Patient *patientInfo;
@property (nonatomic, retain) Pharmacy *pharmacyLocation;

+ (instancetype)createOrderFromContext: (NSManagedObjectContext *)context;

@end
