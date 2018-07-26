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
#import "Pin.h"
#import "PlaceholdViewController.h"


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) MapModel *model;

@property (strong, nonnull) MKUserLocation *previousUserLocation;

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
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    self.mapView.delegate = self;
    self.previousUserLocation = [MKUserLocation new];
//    self.previousUserLocation =  nil;
    [self locationSetup];
    [self fetchItems];
}

//retrieve items array
- (void)fetchItems {
    [self.model fetchItemsWithCompletion:^(NSArray<Item *> *items, NSError *error) {
        if (error) {
            return;
        }
        if (items) {
            self.itemsArray = [items mutableCopy];
            self.filteredItemsArray = [items mutableCopy];
            [self addAnnotations:self.filteredItemsArray];
            [self removeAllPinsButUserLocation];
        } else {
            // HANDLE NO ITEMS
        }
    }];
}

//sets up location manager and user location. Temporary forced YES to use user location. In setUpLocationManager the method to ask the user is present.
- (void)locationSetup{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 200;
    [self.locationManager startUpdatingLocation];
}

//user allowed current location to be used. Update this to only call inner methods when if statement is true. I call startUpdatingLocation in other areas to override.
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
    }
}

//this method is deprecated. What is the new alternative? didUpdateToLocation only is called when user location changes, while didUpdateUserLocation is called various times even when there is no change to user location. I need to use this method to fix the constant zooming to user location in bug.
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"5");
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;//self.mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
    [self.mapView setRegion:mapRegion animated: YES];
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"1");
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:view];
}

//setup the views on each annotation.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
<<<<<<< HEAD:ItemShareApp/ItemShareApp/ViewControllers/Main/MapViewController.m
    //NSLog(@"view for annotation method");
=======
>>>>>>> 649559b8f8626b539cb613b2205096d03b02e379:ItemShareApp/ItemShareApp/ViewControllers/MainControllers/MapViewController.m
    if (annotation == mapView.userLocation){
        if(mapView.userLocation == self.previousUserLocation){
            NSLog(@"in if");
            return nil;
        }
        else{
            NSLog(@"in else");
            MKCoordinateRegion mapRegion;
            mapRegion.center = self.mapView.userLocation.coordinate;//self.mapView.userLocation.coordinate;
            mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
            [self.mapView setRegion:mapRegion animated: YES];
            self.previousUserLocation = mapView.userLocation;
            return nil;
        }
    }
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    pin.pinTintColor = [UIColor blueColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(annotationClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //need to make the white pop up from pin be clickable without adding button on side.
    pin.rightCalloutAccessoryView = button; //adds button to the right. This calls both calloutAcessoryControlTapped, AND the action I selected (annotation clicked). Need to figure out how to set it as just a view not a button with a method. Temp solution.
    pin.canShowCallout = NO;
    pin.draggable = NO;
    pin.highlighted = YES;
    return pin;
}


 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"detailsViewSegue"]){
         DetailsViewController *detailsViewController = [segue destinationViewController];
         MKAnnotationView *view = (MKAnnotationView*)sender;
         Pin *pin = view.annotation;
         for(Item *item in self.itemsArray){
             if(item == pin.item){
                 detailsViewController.item = item;
             }
         }
     }
 }

//Error Domain=kCLErrorDomain Code=2 "(null)"
//cannot make too many calls to geocoder 
- (void)addAnnotations: (NSMutableArray *)filteredItemsArray{ //(MKMapView*)mapView
    for(Item *item in filteredItemsArray){
        [self addAnnotationAtAddress:item];
        // [self addAnnotationAtAddress:item.address withTitle:item.title];
    }
}

- (void)setRegion: (MKMapView *)mapView{
    MKCoordinateRegion currentRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [mapView setRegion:currentRegion animated:false];
}

//work in progress that could be a great method for scalability
- (NSString *)convertCoordinateToAddress: (CLLocation*)location{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            //do not delete
           // NSLog(@"added annotations");
            //always guaranteed to be at least one object
            CLPlacemark *placemark = [placemarks lastObject];
            //CLPlacemark *placemark = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country];
        }
    }];
    
    return @"";
}

- (void)addAnnotationAtAddress: (Item *)item {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:item.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
            Pin *pin = [[Pin alloc] init];
            pin.coordinate = placemark.location.coordinate;
            pin.title = item.title;
            pin.item = item;
            [self.mapView addAnnotation:pin];
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

- (void)removeAllPinsButUserLocation{    MKUserLocation *userlocation = self.mapView.userLocation;
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:self.mapView.annotations];
    if(userlocation != nil){
        [pins removeObject:userlocation];
    }
    [self.mapView removeAnnotations:pins];
    pins = nil;
}

//zooms in to user location (when user location changes). //solution to bug in this method is to create an instance location variable with user location. Compare it to user location passed in to this method. If it is the same, return, if not, update the instance and change the center view.
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    //[MapModel updateUserLocation:self.mapView];
////    MKCoordinateRegion mapRegion;
////    mapRegion.center = self.mapView.userLocation.coordinate;//self.mapView.userLocation.coordinate;
////    mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
////    [self.mapView setRegion:mapRegion animated: YES];
//}

//Commented out by Stephanie. Keeping because she might need it later in her search implementation.

////this method runs once search button is clicked and keyboard goes away. This is an option to reload all the pins, instead of autopopulating the pins (design choice).
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    [self.view endEditing:YES];
//}
//
////closes keyboard once search is clicked.
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    [self.view endEditing:YES];
//    [self.locationManager requestWhenInUseAuthorization];
//}
//
////text changes, update pins with filtered array of items
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    if (searchText.length != 0) {
//        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Item *evaluatedObject, NSDictionary *bindings) {
//            return [evaluatedObject.title rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound;
//        }];
//        NSArray *temp = [self.itemsArray filteredArrayUsingPredicate:predicate];
//        self.filteredItemsArray = [NSMutableArray arrayWithArray:temp];
//    }
//    else {
//        self.filteredItemsArray = self.itemsArray;
//    }
//    [self addAnnotations:self.filteredItemsArray];
//    [self removeAllPinsButUserLocation];
//}



@end
