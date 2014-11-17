//
//  Order.m
//  scriptr
//
//  Created by Andrew Brandt on 11/16/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "Order.h"
#import "DropOff.h"
#import "Patient.h"
#import "Pharmacy.h"


@implementation Order

@dynamic orderId;
@dynamic phoneNumber;
@dynamic dropOffLocation;
@dynamic patientInfo;
@dynamic pharmacyLocation;

+ (instancetype)createOrderFromContext:(NSManagedObjectContext *)context {
    Order *order = [NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext:context];
    return order;
}

@end
