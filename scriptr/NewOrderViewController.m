    //
//  NewOrderViewController.m
//  scriptr
//
//  Created by Andrew Brandt on 11/11/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "NewOrderViewController.h"
#import "PharmacyViewController.h"
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
        NSLog(@"segue complete!");
        NSLog(@"%@", [self.pharmacy pharmacyName]);
    }
}

- (IBAction)unwindToOrder:(UIStoryboardSegue *)unwindSegue {
    //there will be multiple unwinds, need to check source
    PharmacyViewController *source = unwindSegue.sourceViewController;
    self.pharmacy = source.pharmacy;
}

@end
