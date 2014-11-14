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
#import "Pharmacy.h"

@interface NewOrderViewController ()

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
}

- (IBAction)unwindToOrder:(UIStoryboardSegue *)unwindSegue {
    //there will be multiple unwinds, need to check source
    NSLog(@"segue complete!");
    if ([[unwindSegue.sourceViewController class] isKindOfClass:[PharmacyViewController class]]) {
        PharmacyViewController *source = unwindSegue.sourceViewController;
        self.pharmacy = source.pharmacy;
    } else if ([[unwindSegue.sourceViewController class] isKindOfClass:[PatientViewController class]]) {
        PatientViewController *source = unwindSegue.sourceViewController;
        //self.pharmacy = source.patient;
    }
}

@end
