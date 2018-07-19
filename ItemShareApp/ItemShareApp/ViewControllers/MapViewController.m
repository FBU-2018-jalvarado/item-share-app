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
- (void)locationSetup{
    BOOL permission = YES;
    if(permission){
        [self setUpLocationManager];
        self.mapView.showsUserLocation = YES; //works without it? but online insists on it
    }
    else{
        [self setRegion]; //sets SF regions
    }
}


- (void)addAnnotations{
    for(Item *item in self.filteredItemsArray){
         [self addAnnotationAtAddress:item.address withTitle:item.title];
    }
}

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
    [self addAnnotations];
    [self removeAllPinsButUserLocation];
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
                [self addAnnotations];
                [self removeAllPinsButUserLocation];
                
            }
        }
    }];
}



//MAP IMPLEMENTATION




//only for specific region, calls the area of San Francisco when no location services available.
- (void)setRegion{
    MKCoordinateRegion currentRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:currentRegion animated:false];
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
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
    [self.mapView setRegion:mapRegion animated: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//for later implementation. Plan to allow seller to set a pin for the pickup location instead of address, which will send in a coordinate instead. Can use this or implement a method to convert from coordinate to address.
- (void)addAnnotationAtCoordinate: (CLLocationCoordinate2D)coordinate { //why no stars on this? is this not an object?
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"annotation!";
    [self.mapView addAnnotation:annotation];
}

- (void)addAnnotationAtAddress: (NSString *)address withTitle:(NSString*)title{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            NSLog(@"added annotations");
            CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = placemark.location.coordinate;
            annotation.title = title;
            [self.mapView addAnnotation:annotation];
        }
    }];
}

//the view on the annotation pin was tapped, send to details
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:nil];
    
}

//setup the views on each annotation.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if (annotation == mapView.userLocation) return nil;
    
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    pin.pinTintColor = [UIColor blueColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(annotationClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //need to make the white pop up from pin be clickable without adding button on side.
    pin.rightCalloutAccessoryView = button; //adds button to the right. This calls both calloutAcessoryControlTapped, AND the action I selected (annotation clicked). Need to figure out how to set it as just a view not a button with a method. Temp solution.
    pin.draggable = NO;
    pin.highlighted = YES;
    pin.canShowCallout = YES;
    return pin;
}

- (void)annotationClicked {
   // NSLog(@"clicked");
}

- (void)removeAllPinsButUserLocation{
    MKUserLocation *userlocation = self.mapView.userLocation;
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:self.mapView.annotations];
    if(userlocation != nil){
        [pins removeObject:userlocation];
    }
    [self.mapView removeAnnotations:pins];
    pins = nil;
}


//commented out. This method begins the implementation to add pins as images, so I commited it for later optional work.

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
//    if (annotationView == nil) {
//        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
//        annotationView.canShowCallout = true;
//        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
//    }
//    return annotationView;
//}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"detailsViewSegue"]){
         DetailsViewController *detailsViewController = [segue destinationViewController];
         detailsViewController.item = self.item;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }



@end
