//
//  Patient.m
//  scriptr
//
//  Created by Andrew Brandt on 11/13/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "Patient.h"


@implementation Patient

@dynamic patientFirstName;
@dynamic patientLastName;
@dynamic patientBirthDate;
@dynamic patientAddress;

+ (instancetype)createPatientFromContext:(NSManagedObjectContext *)context {
    Patient *patient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:context];
    return patient;
}

@end
