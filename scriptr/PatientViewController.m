//
//  PatientViewController.m
//  scriptr
//
//  Created by Andrew Brandt on 11/13/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "PatientViewController.h"
#import "NewOrderViewController.h"
#import "Models.h"
#import "AppDelegate.h"

@interface PatientViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirth;

@end

@implementation PatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Patient *patient = [Patient createPatientFromContext:self.context];
    [patient setPatientAddress:self.address.text];
    [patient setPatientBirthDate:self.dateOfBirth.text];
    [patient setPatientFirstName:self.firstName.text];
    [patient setPatientLastName:self.lastName.text];
    NewOrderViewController *source = segue.destinationViewController;
    source.patient = patient;
}

@end
