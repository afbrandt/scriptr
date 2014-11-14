//
//  NewOrderViewController.h
//  scriptr
//
//  Created by Andrew Brandt on 11/11/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Pharmacy;
@class Patient;

@interface NewOrderViewController : UIViewController

@property (nonatomic, strong) Pharmacy *pharmacy;
@property (nonatomic, strong) Patient *patient;

@end
