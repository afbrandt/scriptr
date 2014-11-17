//
//  PreviewOrderViewController.m
//  scriptr
//
//  Created by Andrew Brandt on 11/16/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "PreviewOrderViewController.h"
#import "Models.h"

@interface PreviewOrderViewController ()

@property (weak, nonatomic) IBOutlet UILabel *pharmacyLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientLabel;
@property (weak, nonatomic) IBOutlet UILabel *dropOffLabel;

@end

@implementation PreviewOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pharmacyLabel.text = [[self.order pharmacyLocation] pharmacyName];
    self.patientLabel.text = [[self.order patientInfo] patientFirstName];
    self.dropOffLabel.text = [[self.order dropOffLocation] dropOffAddress];
}

@end
