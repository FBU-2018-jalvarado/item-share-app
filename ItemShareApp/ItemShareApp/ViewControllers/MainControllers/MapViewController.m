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
#import "myAnnotation.h"
#import <ClusterKit/MKMapView+ClusterKit.h>
#import <QuartzCore/QuartzCore.h>

NSString * const CKMapViewDefaultAnnotationViewReuseIdentifier = @"customAnnotation";
NSString * const CKMapViewDefaultClusterAnnotationViewReuseIdentifier = @"cluster";


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
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
    
    CKNonHierarchicalDistanceBasedAlgorithm *algorithm = [CKNonHierarchicalDistanceBasedAlgorithm new];
    algorithm.cellSize = 100;
    
   // self.mapView.clusterManager.algorithm = algorithm;
    //self.mapView.clusterManager.marginFactor = 1;
    
    self.locationManager.delegate = self;
    self.searchBar.delegate = self;
    self.mapView.delegate = self;
    self.previousUserLocation = [MKUserLocation new];
    
    
    self.titleLabel.layer.cornerRadius = 10;
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.layer.shadowOpacity = 1.0;
    self.titleLabel.layer.shadowRadius = 0.0;
    self.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.titleLabel.layer.shadowOffset = CGSizeMake(5.0, 5.0);
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
            //self.mapView.clusterManager.annotations = self.filteredItemsArray;
            //THIS IS THE ERROR. WAS ASSIGNING ANNOTATIONS ARRAY WITH ITEMS
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

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"1");
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:view];
}

/*
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [mapView.clusterManager updateClustersIfNeeded];
}
 */

//setup the views on each annotation.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //NSLog(@"view for annotation method");
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
    /*
    CKCluster *cluster = (CKCluster *)annotation;
    
    if (cluster) {
        MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:CKMapViewDefaultClusterAnnotationViewReuseIdentifier];
        if (view) {
            return view;
        }
        return [[CKClusterView alloc] initWithAnnotation:cluster reuseIdentifier:CKMapViewDefaultClusterAnnotationViewReuseIdentifier];
    }
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:CKMapViewDefaultAnnotationViewReuseIdentifier];
    if (view) {
        return view;
    }
    return [[CKClusterView alloc] initWithAnnotation:cluster reuseIdentifier:CKMapViewDefaultAnnotationViewReuseIdentifier];
    */
    if([annotation isKindOfClass:[myAnnotation class]]){
        myAnnotation *customAnnotation = (myAnnotation*)annotation;
        MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:CKMapViewDefaultAnnotationViewReuseIdentifier];

        if(!annotationView){
            annotationView = customAnnotation.annotationView;
        }
        else{
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
    
//    //old
//    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
//    pin.pinTintColor = [UIColor blueColor];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    [button addTarget:self action:@selector(annotationClicked) forControlEvents:UIControlEventTouchUpInside];
//
//    //need to make the white pop up from pin be clickable without adding button on side.
//    pin.rightCalloutAccessoryView = button; //adds button to the right. This calls both calloutAcessoryControlTapped, AND the action I selected (annotation clicked). Need to figure out how to set it as just a view not a button with a method. Temp solution.
//    pin.canShowCallout = NO;
//    pin.draggable = NO;
//    pin.highlighted = YES;
//    return pin;
}


 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"detailsViewSegue"]){
         DetailsViewController *detailsViewController = [segue destinationViewController];
         MKAnnotationView *view = (MKAnnotationView*)sender;
         myAnnotation *annotation = view.annotation;
         for(Item *item in self.itemsArray){
             if(item == annotation.item){
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
            myAnnotation *annotation = [[myAnnotation alloc]initWithLocation:placemark.location.coordinate];
            annotation.title = item.title;
            annotation.item = item;
            [self.mapView addAnnotation:annotation];
//            Pin *pin = [[Pin alloc] init];
//            pin.coordinate = placemark.location.coordinate;
//            pin.title = item.title;
//            pin.item = item;
//            [self.mapView addAnnotation:pin];
        }
    }];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
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


- (IBAction)profileButtonPressed:(id)sender {
    [self.mapDelegate openSideProfile];
}


//placeholder code. This should be in profile view controllers to update the history.


//zooms in to user location (when user location changes). //solution to bug in this method is to create an instance location variable with user location. Compare it to user location passed in to this method. If it is the same, return, if not, update the instance and change the center view.
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //[MapModel updateUserLocation:self.mapView];
//    MKCoordinateRegion mapRegion;
//    mapRegion.center = self.mapView.userLocation.coordinate;//self.mapView.userLocation.coordinate;
//    mapRegion.span = MKCoordinateSpanMake(0.5, 0.5);
//    [self.mapView setRegion:mapRegion animated: YES];
//}


@end

/*
@implementation CKAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.canShowCallout = YES;
        self.draggable = YES;
        self.image = [UIImage imageNamed:@"marker"];
    }
    return self;
}


@end

@implementation CKClusterView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [UIImage imageNamed:@"cluster"];
    }
    return self;
}

@end
*/
