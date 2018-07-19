//
//  MapViewController.m
//  ItemShareApp
//
//  Created by Nicolas Machado on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
// test
// hello

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailsViewController.h"
#import "Parse.h"


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *filteredItemsArray;
@property (strong, nonatomic) Item *item;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.mapView.delegate = self;
    [self locationSetup];
    [self fetchItems];
}

//sets up location manager and user location. Temporary forced YES to use user location. In setUpLocationManager the method to ask the user is present.

//this method runs once search button is clicked and keyboard goes away. This is an option to reload all the pins, instead of autopopulating the pins (design choice).
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}

//closes keyboard once search is clicked.
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}

//text changes, update pins with filtered array of items
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        // commented out because need to pull model class to implement these lines of code. Commmiting to pull.
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Item *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.title rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound;
        }];
        NSArray *temp = [self.itemsArray filteredArrayUsingPredicate:predicate];
        self.filteredItemsArray = [NSMutableArray arrayWithArray:temp];
    }
    else {
        self.filteredItemsArray = self.itemsArray;
    }
    [MapModel addAnnotations:self.mapView withArray:self.filteredItemsArray];
    [MapModel removeAllPinsButUserLocation:self.mapView];
    //[self.tableView reloadData];
}

//retrieve items array
- (void)fetchItems {
    
    PFQuery *itemQuery = [Item query];
    //PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [itemQuery orderByDescending:@"createdAt"];
    [itemQuery includeKey:@"location"];
    [itemQuery includeKey:@"title"];
    [itemQuery includeKey:@"owner"];
    [itemQuery includeKey:@"address"];
    itemQuery.limit = 20;
    
    // fetch data asynchronously
    [itemQuery findObjectsInBackgroundWithBlock:^(NSArray<Item *> * _Nullable items, NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"ERROR GETTING THE ITEMS!");
        }
        else {
            if (items) {
                self.itemsArray = [[NSMutableArray alloc] init];
                for(Item *newItem in items)
                {
                    [self.itemsArray addObject:newItem];
                }
                // self.itemsArray = [self.itemsArray arrayByAddingObjectsFromArray:items];
                //self.itemsArray = items;
                self.filteredItemsArray = self.itemsArray;
                NSLog(@"SUCCESSFULLY RETREIVED ITEMS!");
              //  [self.tableView reloadData];
                [MapModel addAnnotations:self.mapView withArray:self.filteredItemsArray];
                [MapModel removeAllPinsButUserLocation:self.mapView];
                
            }
        }
    }];
}



//MAP IMPLEMENTATION


- (void)locationSetup{
    BOOL permission = YES;
    if(permission){
        [self setUpLocationManager];
        self.mapView.showsUserLocation = YES; //works without it? but online insists on it
    }
    else{
        [MapModel setRegion:self.mapView];
//        [self setRegion]; moved to mapModel
    }
}

//location manager delegate for control
- (void)setUpLocationManager{
    [self setLocationManager:self.locationManager];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 200;
    [self.locationManager requestWhenInUseAuthorization];
}

//user allowed current location to be used
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
    }
}

//not necessary anymore. Replaced this with didUpdateUserLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.location = [locations firstObject]; //was an "if let" in swift. How do I handle this in objective C? Completion? Block? Sounds like too much
}

//zooms in to user location (when user location changes)
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //[MapModel updateUserLocation:self.mapView];
    MKCoordinateRegion mapRegion;
    mapRegion.center = userLocation.coordinate;//self.mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
    [self.mapView setRegion:mapRegion animated: YES];
}



//the view on the annotation pin was tapped, send to details
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:view.annotation.title];
    
}

//setup the views on each annotation.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    return [MapModel mapViewHelper:mapView viewForAnnotation:annotation];
}

- (void)annotationClicked {
   // NSLog(@"clicked");
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"detailsViewSegue"]){
         DetailsViewController *detailsViewController = [segue destinationViewController];
        // MKAnnotationView *view = (MKAnnotationView*)sender;
         for(Item *item in self.itemsArray){
//             if([item.title isEqualToString:view.annotation.title]){
//                 detailsViewController.item = self.item;
//             }
             //get the correct item (compare item title to pin title (sender is annotation)
         }
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }



@end
