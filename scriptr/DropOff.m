//
//  DropOff.m
//  scriptr
//
//  Created by Andrew Brandt on 11/16/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "DropOff.h"

@implementation DropOff

@dynamic dropOffAddress;
@dynamic dropOffLongitude;
@dynamic dropOffLatitude;

+ (instancetype)createDropOffFromContext:(NSManagedObjectContext *)context {
    DropOff *location = [NSEntityDescription insertNewObjectForEntityForName:@"DropOff" inManagedObjectContext:context];
    return location;
}

@end
