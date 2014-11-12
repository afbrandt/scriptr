//
//  PharmacyViewController.m
//  scriptr
//
//  Created by Andrew Brandt on 11/11/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "PharmacyViewController.h"
#import "WebRequestHelper.h"

@interface PharmacyViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *locations;
@property (assign, nonatomic) BOOL didUpdateLocation;
@property (assign, nonatomic) CLLocationCoordinate2D currentLocation;

@end

@implementation PharmacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [CLLocationManager new];
    
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        self.didUpdateLocation = NO;
    }
    
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocationCoordinate2D userLoc = [(CLLocation *)locations[locations.count-1] coordinate];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLoc, span);
    self.currentLocation = userLoc;
    if (!self.didUpdateLocation) {
        [self.mapView setRegion:region animated:YES];
        self.didUpdateLocation = YES;
        [[WebRequestHelper sharedHelper] getDefaultPharmacyLocations:self.currentLocation withBlock:^(NSArray *locations) {
            NSLog(@"callback!");
            self.locations = locations;
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(searchBar.text);
    
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PharmacyCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.locations[indexPath.row][@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", self.locations[indexPath.row][@"name"]);
    
    return indexPath;
}

@end
