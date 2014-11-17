//
//  PharmacyTableViewCell.h
//  scriptr
//
//  Created by Andrew Brandt on 11/16/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PharmacyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *pharmacyName;
@property (weak, nonatomic) IBOutlet UILabel *pharmacyAddress;

@end
