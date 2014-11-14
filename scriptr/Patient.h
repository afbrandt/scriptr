//
//  Patient.h
//  scriptr
//
//  Created by Andrew Brandt on 11/13/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Patient : NSManagedObject

@property (nonatomic, retain) NSString * patientFirstName;
@property (nonatomic, retain) NSString * patientLastName;
@property (nonatomic, retain) NSString * patientBirthDate;
@property (nonatomic, retain) NSString * patientAddress;

+ (instancetype)createPatientFromContext: (NSManagedObjectContext *)context;

@end
