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
    NSLog(@"%@", [unwindSegue.sourceViewController class]);
    NSLog(@"segue complete!");
    if ([unwindSegue.sourceViewController isKindOfClass:[PharmacyViewController class]]) {
        self.pharmacyLabel.transform = CGAffineTransformMakeScale(1.0f, 0.01f);
        self.pharmacyLabel.text = [self.pharmacy pharmacyName];
        self.pharmacyLabel.hidden = NO;
        //self.pharmacyButton.backgroundColor = [UIColor greenColor];
        [UIView animateWithDuration:0.5f animations:^{
            self.pharmacyLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    } else if ([unwindSegue.sourceViewController isKindOfClass:[PatientViewController class]]) {
        NSString *fullName = [NSString stringWithFormat:@"%@ %@", [self.patient patientFirstName], [self.patient patientLastName]];
        self.patientLabel.transform = CGAffineTransformMakeScale(1.0f, 0.01f);
        self.patientLabel.text = fullName;
        self.patientLabel.hidden = NO;
        [UIView animateWithDuration:0.5f animations:^{
            self.patientLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
        
    } else if ([unwindSegue.sourceViewController isKindOfClass:[DropOffViewController class]]) {
        NSString *addressSnip = [[self.dropOff dropOffAddress] componentsSeparatedByString:@","][0];
        self.dropOffLabel.text = addressSnip;
        self.dropOffLabel.transform = CGAffineTransformMakeScale(1.0f, 0.01f);
        self.dropOffLabel.hidden = NO;
        [UIView animateWithDuration:0.5f animations:^{
            self.dropOffLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    }
}

@end
