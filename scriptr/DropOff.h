//
//  DropOff.h
//  scriptr
//
//  Created by Andrew Brandt on 11/16/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DropOff : NSManagedObject

@property (nonatomic, retain) NSString * dropOffAddress;
@property (nonatomic, retain) NSNumber * dropOffLongitude;
@property (nonatomic, retain) NSNumber * dropOffLatitude;

+ (instancetype)createDropOffFromContext: (NSManagedObjectContext *)context;

@end
