//
//  NewOrderViewController.m
//  scriptr
//
//  Created by Andrew Brandt on 11/11/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "NewOrderViewController.h"
#import "PharmacyViewController.h"
#import "PatientViewController.h"
#import "DropOffViewController.h"
#import "Pharmacy.h"
#import "Patient.h"
#import "DropOff.h"

@interface NewOrderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pharmacyLabel;
@property (weak, nonatomic) IBOutlet UIButton *pharmacyButton;
@property (weak, nonatomic) IBOutlet UILabel *dropOffLabel;
@property (weak, nonatomic) IBOutlet UIButton *dropOffButton;
@property (weak, nonatomic) IBOutlet UILabel *patientLabel;
@property (weak, nonatomic) IBOutlet UIButton *patientButton;
@end

@implementation NewOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.pharmacy) {
        NSLog(@"%@", [self.pharmacy pharmacyName]);
    }
    if (self.patient) {
        NSLog(@"%@", [self.patient patientFirstName]);
    }
    if (self.dropOff) {
        NSLog(@"%@", [self.dropOff dropOffAddress]);
    }
}

- (IBAction)unwindToOrder:(UIStoryboardSegue *)unwindSegue {
    //there will be multiple unwinds, need to check source
    NSLog(@"%@", [unwindSegue.sourceViewController class]);
    NSLog(@"segue complete!");
    if ([unwindSegue.sourceViewController isKindOfClass:[PharmacyViewController class]]) {
        self.pharmacyLabel.text = [self.pharmacy pharmacyName];
        self.pharmacyButton.backgroundColor = [UIColor greenColor];
    } else if ([unwindSegue.sourceViewController isKindOfClass:[PatientViewController class]]) {
        NSString *fullName = [NSString stringWithFormat:@"%@ %@", [self.patient patientFirstName], [self.patient patientLastName]];
        self.patientLabel.text = fullName;
        
    } else if ([unwindSegue.sourceViewController isKindOfClass:[DropOffViewController class]]) {
        NSString *addressSnip = [[self.dropOff dropOffAddress] componentsSeparatedByString:@","][0];
        self.dropOffLabel.text = addressSnip;
    }
}

@end
