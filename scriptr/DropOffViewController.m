//
//  DropOffViewController.m
//  scriptr
//
//  Created by Andrew Brandt on 11/14/14.
//  Copyright (c) 2014 makeschool. All rights reserved.
//

#import "DropOffViewController.h"
#import "WebRequestHelper.h"
#import "AppDelegate.h"

@interface DropOffViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *locations;
@property (assign, nonatomic) BOOL didUpdateLocation;
@property (assign, nonatomic) CLLocationCoordinate2D currentLocation;

@end

@implementation DropOffViewController

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
    
    self.context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)reloadAnnotations {
    [self.mapView removeAnnotations:[self.mapView annotations]];
    for (int i = 0; i < [self.locations count]; i++) {
        float lat, lng;
        lat = [self.locations[i][@"geometry"][@"location"][@"lat"] floatValue];
        lng = [self.locations[i][@"geometry"][@"location"][@"lng"] floatValue];
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lat, lng);
        MKPointAnnotation *pin = [MKPointAnnotation new];
        pin.coordinate = location;
        [self.mapView addAnnotation:pin];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@", self.locations[self.tableView.indexPathForSelectedRow.row][@"name"]);
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
        [[WebRequestHelper sharedHelper] getDefaultDropOffLocation:self.currentLocation withBlock:^(NSArray *locations) {
            NSLog(@"callback!");
            //need to handle zero result search
            self.locations = locations;
            [self.tableView reloadData];
            [self reloadAnnotations];
        }];
    }
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(searchBar.text);
    [[WebRequestHelper sharedHelper] getDefaultDropOffLocation:self.currentLocation withBlock:^(NSArray *locations) {
        NSLog(@"callback!");
        //need to handle zero result search
        self.locations = locations;
        [self.tableView reloadData];
        [self reloadAnnotations];
    }];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropOffCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.locations[indexPath.row][@"formatted_address"];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", self.locations[indexPath.row][@"formatted_address"]);
    
    NSArray *pins = [self.mapView annotations];
    MKPointAnnotation *pin = pins[indexPath.row];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    MKCoordinateRegion region = MKCoordinateRegionMake(pin.coordinate, span);
    
    [self.mapView setRegion:region animated:YES];
    
    return indexPath;
}

@end
