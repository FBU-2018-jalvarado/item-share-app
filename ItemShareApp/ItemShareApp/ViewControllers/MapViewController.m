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
@property (strong, nonatomic) MapModel *model;

@end

@implementation MapViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[MapModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
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
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Item *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.title rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound;
        }];
        NSArray *temp = [self.itemsArray filteredArrayUsingPredicate:predicate];
        self.filteredItemsArray = [NSMutableArray arrayWithArray:temp];
    }
    else {
        self.filteredItemsArray = self.itemsArray;
    }
    [self addAnnotations:self.mapView withArray:self.filteredItemsArray];
    [self removeAllPinsButUserLocation];
}

//retrieve items array
- (void)fetchItems {
    [self.model getAddressLocationsWithCompletion:^(NSArray<Item *> *items, NSError *error) {
        if (error) {
            return;
        }
        if (items) {
            self.itemsArray = [items mutableCopy];
            self.filteredItemsArray = [items mutableCopy];
            [self addAnnotations:self.mapView withArray:self.filteredItemsArray];
            [self removeAllPinsButUserLocation];
        } else {
            // HANDLE NO ITEMS
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
        [self setRegion:self.mapView];
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
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    self.location = [locations firstObject]; //was an "if let" in swift. How do I handle this in objective C? Completion? Block? Sounds like too much
//}

//zooms in to user location (when user location changes)
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //[MapModel updateUserLocation:self.mapView];
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;//self.mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
    [self.mapView setRegion:mapRegion animated: YES];
}

//the view on the annotation pin was tapped, send to details
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:view.annotation.title];
}

//setup the views on each annotation.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    return [self mapViewHelper:mapView viewForAnnotation:annotation];
}

- (void)annotationClicked {
   // NSLog(@"clicked");
}

 #pragma mark - Navigation

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
 }

- (void)addAnnotations: (MKMapView*)mapView withArray: (NSMutableArray *)filteredItemsArray{
    for(Item *item in filteredItemsArray){
        [self addAnnotationAtAddress:item.address withTitle:item.title];
        // [self addAnnotationAtAddress:item.address withTitle:item.title];
    }
}

- (void)setRegion: (MKMapView *)mapView{
    MKCoordinateRegion currentRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [mapView setRegion:currentRegion animated:false];
}

- (NSString *)convertCoordinateToAddress: (CLLocation*)location{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            NSLog(@"added annotations");
            CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
            //            // = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
            //                                            placemark.subThoroughfare, placemark.thoroughfare,
            //                                            placemark.postalCode, placemark.locality,
            //                                            placemark.administrativeArea,
            //                                            placemark.country];
        }
    }];
    
    return @"";
}

- (void)addAnnotationAtAddress: (NSString *)address withTitle:(NSString*)title {
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

//for later implementation. Plan to allow seller to set a pin for the pickup location instead of address, which will send in a coordinate instead. Can use this or implement a method to convert from coordinate to address.
- (void)addAnnotationAtCoordinate: (CLLocationCoordinate2D)coordinate { //why no stars on this? is this not an object?
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"annotation!";
    [self.mapView addAnnotation:annotation];
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

- (MKAnnotationView *)mapViewHelper:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if (annotation == mapView.userLocation){
        MKCoordinateRegion mapRegion;
        mapRegion.center = mapView.userLocation.coordinate;//self.mapView.userLocation.coordinate;
        mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
        [mapView setRegion:mapRegion animated: YES];
        return nil;
    }
    
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



@end
