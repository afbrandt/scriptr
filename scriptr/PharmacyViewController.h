//
//  PharmacyViewController.h
//  scriptr
//
//  Created by Andrew Brandt on 11/11/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
@class Pharmacy;

@interface PharmacyViewController : UIViewController<CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) Pharmacy *pharmacy;

@end
