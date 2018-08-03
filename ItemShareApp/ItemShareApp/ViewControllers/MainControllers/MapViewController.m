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
NSString * const CKMapViewDefaultAnnotationViewReuseIdentifier = @"customAnnotation";
NSString * const CKMapViewDefaultClusterAnnotationViewReuseIdentifier = @"cluster";

NSString * const kMapStyleURLString = @"https://maps.googleapis.com/maps/api/staticmap?key=AIzaSyDWcPqlz31jbQEqzivaqzfoFZc3BeJbqwk&center=-33.9,151.14999999999998&zoom=12&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x212121&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x757575&style=element:labels.text.stroke%7Ccolor:0x212121&style=feature:administrative%7Celement:geometry%7Ccolor:0x757575&style=feature:administrative.country%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0x181818&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:poi.park%7Celement:labels.text.stroke%7Ccolor:0x1b1b1b&style=feature:road%7Celement:geometry.fill%7Ccolor:0x2c2c2c&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x8a8a8a&style=feature:road.arterial%7Celement:geometry%7Ccolor:0x373737&style=feature:road.highway%7Celement:geometry%7Ccolor:0x3c3c3c&style=feature:road.highway%7Celement:geometry.stroke%7Cvisibility:on&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0x4e4e4e&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:water%7Celement:geometry%7Ccolor:0x000000&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x3d3d3d&size=480x360";


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
    // self.mapView.delegate = self;
    self.googleMapView.delegate = self;
    //self.previousUserLocation = [MKUserLocation new];
    
    self.mapStyleURL = [NSURL URLWithString:kMapStyleURLString];
    [self setUpUIGoogle];
    [self setUpStyle];
    [self locationSetup];
    [self fetchItems];
    
    
    // [self setUpUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setUpStyle {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"style" withExtension:@"json"];
    NSError *error;
    
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    
    self.googleMapView.mapStyle = style;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    [self performSegueWithIdentifier:@"detailsViewSegue" sender:marker];
    return YES;
}

- (void)setUpUIGoogle {
    UIColor *color = [UIColor colorWithRed:255.0f/255.0f green:139.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    self.profileButton.backgroundColor = color;
    self.homeButtonBackgroundView.backgroundColor = color;
    self.homeButtonBackgroundView.layer.cornerRadius = 24;
    self.profileButton.layer.cornerRadius = 24;
    self.fetchLabel.textColor = color;
    //    self.fetchLabel.layer.cornerRadius = 5;
    //    self.fetchLabel.layer.borderWidth = 3;
    //    self.fetchLabel.layer.borderColor = color.CGColor;
    //self.googleMapView.settings.compassButton = YES;
    // self.googleMapView.settings.myLocationButton = YES;
    //    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37.4530 , -122.1817);
    //    self.googleMapView.camera = [GMSCameraPosition cameraWithTarget:coordinate zoom:10 bearing:0 viewingAngle:0];
    //    self.googleMapView.myLocationEnabled = YES;
    //    // Creates a marker in the center of the map.
    //    NSLog(@"the user location is: %@", self.googleMapView.myLocation);
    //
    //    GMSMarker *marker = [[GMSMarker alloc] init];
    //    marker.position = CLLocationCoordinate2DMake(37.783333, -122.416667);
    //    marker.title = @"Sydney";
    //    marker.snippet = @"Australia";
    //    marker.map = self.googleMapView;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    //if (abs(howRecent) < 15.0) {
    self.previousUserLocation = location;
    self.googleMapView.myLocationEnabled = YES;
    self.googleMapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:10 bearing:0 viewingAngle:0];
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
            //self.mapView.clusterManager.annotations = self.filteredItemsArray;
            //THIS IS THE ERROR. WAS ASSIGNING ANNOTATIONS ARRAY WITH ITEMS
            [self removeAllMarkersButUserLocation];
            [self addMarkers:self.filteredItemsArray];
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
        // MKAnnotationView *view = (MKAnnotationView*)sender;
        //myMarker *marker = view.annotation;
        //         for(Item *item in self.itemsArray){
        //             if(marker.coordinate != self.googleMapView.myLocation.coordinate && item == marker.item){ //if it is user location, there is no item
        //                 detailsViewController.item = item;
        //             }
        //         }
    }
}

//Error Domain=kCLErrorDomain Code=2 "(null)"
//cannot make too many calls to geocoder
- (void)addMarkers: (NSMutableArray *)filteredItemsArray{ //(MKMapView*)mapView
    for(Item *item in filteredItemsArray){
        [self addMarker:item];
    }
}

//- (void)setRegion: (MKMapView *)mapView{
//    MKCoordinateRegion currentRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
//    [mapView setRegion:currentRegion animated:false];
//}

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

- (void)addMarker: (Item *)item {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
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
            marker.title = item.title;
            UIColor *color = [UIColor colorWithRed:255.0f/255.0f green:185.0f/255.0f blue:38.0f/255.0f alpha:1.0f];
            marker.icon = [UIImage imageNamed:@"dogPin2"];
            marker.item = item;
            marker.map = self.googleMapView;
        }
    }];
    /*  [geocoder geocodeAddressString:item.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
     if(error){
     NSLog(@"%@", error);
     }
     else{
     CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
     myMarker *marker = [[myMarker alloc]initWithLocation:placemark.location.coordinate];
     [self.markersArray addObject:marker];
     marker.title = item.title;
     marker.item = item;
     marker.map = self.googleMapView;
     
     
     
     //            myAnnotation *annotation = [[myAnnotation alloc]initWithLocation:placemark.location.coordinate];
     //            annotation.title = item.title;
     //            annotation.item = item;
     //            [self.mapView addAnnotation:annotation];
     }
     }];*/
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

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//
//}

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
    // NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:self.markersArray];
    //    if(userlocation != nil){
    //        [pins removeObject:userlocation];
    //    }
    // [self.mapView removeAnnotations:pins];
    
    for(myMarker *marker in self.markersArray){
        marker.map = nil;
    }
    [self.markersArray removeAllObjects];
}

- (IBAction)recenterButtonPressed:(id)sender {
    self.googleMapView.camera = [GMSCameraPosition cameraWithTarget:self.googleMapView.myLocation.coordinate zoom:10 bearing:0 viewingAngle:0];
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
            /*
             MKMapItem *myMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
             MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
             [request setSource:[MKMapItem mapItemForCurrentLocation]];
             [request setDestination:myMapItem];
             [request setTransportType:MKDirectionsTransportTypeAny]; // This can be limited to automobile and walking directions.
             [request setRequestsAlternateRoutes:YES]; // Gives you several route options.
             MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
             [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
             if(error){
             NSLog(@"%@", error);
             }
             if (!error) {
             for (MKRoute *route in [response routes]) {
             [self.mapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads]; // Draws the route above roads, but below labels.
             // You can also get turn-by-turn steps, distance, advisory notices, ETA, etc by accessing various route properties.
             }
             }
             }];*/
        }
    }];
}

/*- (void)setUpUI {
 
 //[self.mapView setMapType:MKMapTypeStandard];
 self.mapView.tintColor = [UIColor redColor];
 self.mapView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
 
 //baseView
 self.titleView.backgroundColor = [UIColor clearColor];
 self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;
 self.titleView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
 self.titleView.layer.shadowOpacity = 1.0;
 self.titleView.layer.shadowRadius = 4.0;
 
 self.titleLabel.frame = self.titleView.bounds;
 self.titleLabel.layer.cornerRadius = 10;
 self.titleLabel.layer.masksToBounds = YES;
 [self.titleView addSubview:self.titleLabel];
 
 //map UI
 self.mapView.showsScale = NO;
 self.mapView.showsCompass = NO;
 
 //scale
 MKScaleView *scale = [MKScaleView scaleViewWithMapView:self.mapView];
 [scale setScaleVisibility:MKFeatureVisibilityVisible];
 scale.frame = CGRectMake(5, -80, scale.frame.size.width, scale.frame.size.width);
 [self.view addSubview:scale];
 
 //compass
 MKCompassButton *compass = [MKCompassButton compassButtonWithMapView:self.mapView];
 compass.frame = CGRectMake(self.view.frame.size.width - 47, self.view.frame.origin.y + 240, compass.frame.size.width, compass.frame.size.width);
 [compass setCompassVisibility:MKFeatureVisibilityVisible];
 [self.view addSubview:compass];
 
 
 //buttons
 self.profileButton.layer.shadowColor = [UIColor blackColor].CGColor;
 self.profileButton.layer.shadowOffset = CGSizeMake(2.0, 2.0);
 self.profileButton.layer.shadowOpacity = 0.6;
 self.profileButton.layer.shadowRadius = 4.0;
 self.profileButton.layer.masksToBounds = NO;
 
 self.postButton.layer.shadowColor = [UIColor blackColor].CGColor;
 self.postButton.layer.shadowOffset = CGSizeMake(2.0, 2.0);
 self.postButton.layer.shadowOpacity = 0.6;
 self.postButton.layer.shadowRadius = 4.0;
 self.postButton.layer.masksToBounds = NO;
 
 self.recenterButton.layer.shadowColor = [UIColor blackColor].CGColor;
 self.recenterButton.layer.shadowOffset = CGSizeMake(2.0, 2.0);
 self.recenterButton.layer.shadowOpacity = 0.6;
 self.recenterButton.layer.shadowRadius = 4.0;
 self.recenterButton.layer.masksToBounds = NO;
 
 
 //add border view
 UIView *borderView = [UIView new];
 borderView.frame = self.titleView.bounds;
 borderView.layer.cornerRadius = 10;
 borderView.layer.borderColor = [UIColor blackColor].CGColor;
 borderView.layer.borderWidth = 1.0;
 borderView.layer.masksToBounds = YES;
 borderView.layer.backgroundColor = [UIColor redColor].CGColor;
 [self.titleView addSubview:borderView];
 
 //add title
 }
 */

//- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[MKPolyline class]]) {
//        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
//        [renderer setStrokeColor:[UIColor blueColor]];
//        [renderer setLineWidth:5.0];
//        return renderer;
//    }
//    return nil;
//}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
//    NSLog(@"1");
//    [self performSegueWithIdentifier:@"detailsViewSegue" sender:view];
//}

/*
 - (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
 [mapView.clusterManager updateClustersIfNeeded];
 }
 */

//setup the views on each annotation.
/*- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
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
 
 if([annotation isKindOfClass:[myMarker class]]){
 myMarker *customMarker = (myMarker*)annotation;
 MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:CKMapViewDefaultAnnotationViewReuseIdentifier];
 
 if(!annotationView){
 // annotationView = customAnnotation.markerView;
 }
 else{
 annotationView.annotation = annotation;
 }
 return annotationView;
 }
 return nil;
 }*/


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
