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
#import "myMarker.h"
#import <ClusterKit/MKMapView+ClusterKit.h>
#import <QuartzCore/QuartzCore.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import "QRPopUpController.h"
#import "SellItemViewController.h"
#import "PreviousViewController.h"
#import "ColorScheme.h"

NSString * const CKMapViewDefaultAnnotationViewReuseIdentifier = @"customAnnotation";
NSString * const CKMapViewDefaultClusterAnnotationViewReuseIdentifier = @"cluster";

@interface MapViewController () <GMSMapViewDelegate, CLLocationManagerDelegate, DetailsViewControllerDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UILabel *fetchLabel;
@property (weak, nonatomic) IBOutlet GMSMapView *googleMapView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) MapModel *model;
@property (strong, nonnull) CLLocation *previousUserLocation;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *viewWithLabel;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *recenterButton;
@property (weak, nonatomic) IBOutlet UIView *homeButtonBackgroundView;

@property (strong, nonatomic) NSURL *mapStyleURL;
@property (strong, nonatomic) NSMutableArray *markersArray;
@property (strong, nonatomic) NSMutableArray *markersItemsArray;


@property (weak, nonatomic) IBOutlet UIButton *QRButton;
@property (strong, nonatomic) QRPopUpController * QRPopUpVC;

@property (strong, nonatomic) ColorScheme *colors;

@end

@implementation MapViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colors = [ColorScheme defaultScheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
    
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    self.googleMapView.delegate = self;
    self.markersArray = [NSMutableArray new];
    self.markersItemsArray = [NSMutableArray new];
    
    [self.mapDelegate showHUD];
    [self fetchItems];
    [self setUpUIGoogle];
   // [self setUpStyle];
    [self locationSetup];
   // [self fetchItems];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

//- (void)setUpStyle {
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSURL *styleUrl = [mainBundle URLForResource:@"styleWhite" withExtension:@"json"];
//    NSError *error;
//
//    // Set the map style by passing the URL for style.json.
//    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
//
//    if (!style) {
//        NSLog(@"The style definition could not be loaded: %@", error);
//    }
//
//    self.googleMapView.mapStyle = style;
//}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:marker];
    return YES;
}

- (void)setUpUIGoogle {
    UIColor *color = self.colors.mainColor;
    
    self.profileButton.backgroundColor = color;
    self.homeButtonBackgroundView.backgroundColor = color;
    self.homeButtonBackgroundView.layer.cornerRadius = 24;
    self.profileButton.layer.cornerRadius = 24;
    self.fetchLabel.textColor = color;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    //if (abs(howRecent) < 15.0) {
    self.previousUserLocation = location;
    self.googleMapView.myLocationEnabled = YES;
    [self.googleMapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:location.coordinate zoom:12]];

    //}
}

//retrieve items array
- (void)fetchItems {
    [self.model fetchItemsWithCompletion:^(NSArray<Item *> *items, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        if (items) {
            self.itemsArray = [items mutableCopy];
            self.filteredItemsArray = [items mutableCopy];
            NSMutableArray *arr = [NSMutableArray new];
            //check if any new items to add
//            for(Item *item in self.filteredItemsArray){
//                if(![self.markersItemsArray containsObject:item]){
//                    [arr addObject:item];
//                }
//            }
//            [self addMarkers:arr];
            
            [self removeAllMarkersButUserLocation];
            [self addMarkers:self.filteredItemsArray];
            [self.mapDelegate dismissHUD];
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailsViewSegue"]){
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.detailsDelegate = self;
        myMarker *marker = (myMarker *)sender;
        detailsViewController.item = marker.item;
    }
    if([segue.identifier isEqualToString:@"sellSegue"]){
        SellItemViewController *sellController = [segue destinationViewController];
        sellController.sellItemDelegate = self;
    }

}

//Error Domain=kCLErrorDomain Code=2 "(null)"
//cannot make too many calls to geocoder
- (void)addMarkers: (NSMutableArray *)filteredItemsArray{ //(MKMapView*)mapView
    for(Item *item in filteredItemsArray){
        [self addMyMarker:item withArraySize:[filteredItemsArray count]];
        //[self addMarker:item withSizeOfArray:[filteredItemsArray count]];
    }
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

- (void)addMarker: (Item *)item withSizeOfArray:(NSInteger *)size {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSLog(@"About to call geocoder in map VC");
    [geocoder geocodeAddressString:item.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
            myMarker *marker = [[myMarker alloc] init];
            marker.position = placemark.location.coordinate;
            marker.snippet = @"Test";
            [self.markersArray addObject:marker];
            [self.markersItemsArray addObject:item];
            marker.title = item.title;
            marker.icon = [UIImage imageNamed:@"pickHole2"];
            marker.item = item;
            marker.address = item.address;
            marker.map = self.googleMapView;
            if(size == 1){
                [self.googleMapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:placemark.location.coordinate zoom:14]];
               // self.googleMapView.camera = [GMSCameraPosition cameraWithTarget:placemark.location.coordinate zoom:14 bearing:0 viewingAngle:0];
            }
        }
    }];
}

- (void)addMyMarker: (Item *)item withArraySize: (NSInteger *)size {
    myMarker *marker = [[myMarker alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(item.point.latitude, item.point.longitude);
    marker.position = coordinate;
    marker.snippet = @"Test";
    [self.markersArray addObject:marker];
    [self.markersItemsArray addObject:item];
    marker.title = item.title;
    marker.icon = [UIImage imageNamed:@"pickHole2"];
    marker.item = item;
    marker.address = item.address;
    marker.map = self.googleMapView;
    if(size == 1){
        [self.googleMapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:coordinate zoom:14]];
        // self.googleMapView.camera = [GMSCameraPosition cameraWithTarget:placemark.location.coordinate zoom:14 bearing:0 viewingAngle:0];
    }
}

- (void)convertAddressToPlacemark: (NSString *)address withCompletion:(void(^)(CLPlacemark *placemark, NSError *error))completion
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
        }
        else{
            CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(placemark, nil);
            });
        }
    }];
    
}

//for later implementation. Plan to allow seller to set a pin for the pickup location instead of address, which will send in a coordinate instead. Can use this or implement a method to convert from coordinate to address.
- (void)addAnnotationAtCoordinate: (CLLocationCoordinate2D)coordinate { //why no stars on this? is this not an object?
    
    myMarker *marker = [[myMarker alloc]initWithLocation:coordinate];
    [self.markersArray addObject:marker];
    //no item passed in
    //    marker.title = item.title;
    //    marker.item = item;
    marker.map = self.googleMapView;
}

- (void)removeAllMarkersButUserLocation{
    CLLocation *userlocation = self.googleMapView.myLocation;
    for(myMarker *marker in self.markersArray){
        marker.map = nil;
    }
    [self.markersArray removeAllObjects];
    [self.markersItemsArray removeAllObjects];
}

- (IBAction)recenterButtonPressed:(id)sender {
    [self.googleMapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:self.googleMapView.myLocation.coordinate zoom:12]];
    //self.previousUserLocation = mapView.userLocation;
}

- (IBAction)profileButtonPressed:(id)sender {
    [self.mapDelegate openSideProfile];
}

//delegate method. Needs to ask for directions and present
- (void)sendDirectionRequestToMap: (Item *)item {
    [self requestDirections:item];
    
}

- (void)requestDirections: (Item *)item {
    
    MKMapItem *myMapItem = [MKMapItem alloc];
    [self convertAddressToPlacemark:item.address withCompletion:^(CLPlacemark *placemark, NSError *error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            // [myMapItem initWithPlacemark:placemark];
            
            NSString* directionsURL = [NSString stringWithFormat:@"https://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",self.googleMapView.myLocation.coordinate.latitude, self.googleMapView.myLocation.coordinate.longitude, placemark.location.coordinate.latitude, placemark.location.coordinate.longitude];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL] options:@{} completionHandler:^(BOOL success) {}];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL] options:@{} completionHandler:^(BOOL success) {
                    NSLog(@"hi");
                }];
            };
        }
    }];
}

- (void)zoomOutMap {
    [self.googleMapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:self.googleMapView.myLocation.coordinate zoom:9]];
}


@end
