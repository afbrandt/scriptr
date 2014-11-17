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
@class DropOff;

@interface NewOrderViewController : UIViewController

@property (nonatomic, strong) Pharmacy *pharmacy;
@property (nonatomic, strong) Patient *patient;
@property (nonatomic, strong) DropOff *dropOff;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
