//
//  DropOffViewController.h
//  scriptr
//
//  Created by Andrew Brandt on 11/14/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface DropOffViewController : UIViewController<CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *context;

@end
