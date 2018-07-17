//
//  MapViewController.m
//  ItemShareApp
//
//  Created by Nicolas Machado on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    BOOL permission = YES;
    if(permission){
    [self setUpLocationManager];
    self.mapView.showsUserLocation = YES; //works without it? but online insists on it
    }
    else{
        [self setRegion]; //sets SF regions
    }
    [self addAnnotationAtAddress:@"326 Santa Teresa" withTitle:@"Pin!"];
    [self addAnnotationatCoordinate:CLLocationCoordinate2DMake(37.783333, -122.416667)];
    //326 Santa Teresa StStanford, CA 94305
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
    mapRegion.span = MKCoordinateSpanMake(0.2, 0.2);
    [self.mapView setRegion:mapRegion animated: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAnnotationatCoordinate: (CLLocationCoordinate2D)coordinate { //why no stars on this? is this not an object?
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"annotation!";
    [self.mapView addAnnotation:annotation];
}

- (void)addAnnotationAtAddress: (NSString *)address withTitle:(NSString*)title{
    CLGeocoder *geocoder;
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"error getting address");
        }
        if([placemarks count] != 0){
        CLLocation *location = [placemarks firstObject].location;
        MKPointAnnotation *annotation;
        annotation.coordinate = location.coordinate;
        annotation.title = title;
        [self.mapView addAnnotation:annotation];
        }
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
