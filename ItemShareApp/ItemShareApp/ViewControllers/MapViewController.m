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


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation MapViewController

// Set item method for mapView, but unneeded as is taken care of in Item model
//-(void) setItem:(Item *)item{
//    _item = item;
//    self.item.address = item.address;
//    self.item.title = item.title;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // calling own setItem method, but unneeded as is taken care of in Item model
//    [self setItem:self.item];
    
    self.mapView.delegate = self;
    BOOL permission = YES;
    if(permission){
        [self setUpLocationManager];
        self.mapView.showsUserLocation = YES; //works without it? but online insists on it
    }
    else{
        [self setRegion]; //sets SF regions
    }
    [self addAnnotationAtAddress:self.item.address withTitle:self.item.title];
   // [self addAnnotationAtAddress:@"1 Infinite Loop, Cupertino, CA" withTitle:@"Pin!"];
   // [self addAnnotationAtCoordinate:CLLocationCoordinate2DMake(37.783333, -122.416667)];
    
    //1 Infinite Loop, Cupertino, CA
}

//only for specific region, calls the area of San Francisco when no location services available.
- (void)setRegion{
    MKCoordinateRegion currentRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:currentRegion animated:false];
}

- (void)setUpLocationManager{
    [self setLocationManager:self.locationManager];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 200;
    [self.locationManager requestWhenInUseAuthorization];
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
    }
}

//not necessary anymore. Replaced this with didUpdateUserLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.location = [locations firstObject]; //was an "if let" in swift. How do I handle this in objective C? Completion? Block? Sounds like too much
}

//zooms in to user location (when updated)
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.3, 0.3);
    [self.mapView setRegion:mapRegion animated: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
            NSLog(@"success");
            CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = placemark.location.coordinate;
            annotation.title = title;
            [self.mapView addAnnotation:annotation];
        }
    }];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"tapped");
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:nil];
    
}

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
    pin.animatesDrop = TRUE;
    pin.canShowCallout = YES;
    return pin;
}

- (void)annotationClicked {
   // NSLog(@"clicked");
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
         detailsViewController.item = self.testItem;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }



@end
