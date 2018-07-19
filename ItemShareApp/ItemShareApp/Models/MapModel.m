//
//  MapModel.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/19/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "MapModel.h"
#import "Item.h"

@implementation MapModel


+ (void)addAnnotations: (MKMapView*)mapView withArray: (NSMutableArray *)filteredItemsArray{
    for(Item *item in filteredItemsArray){
        [self addAnnotationAtAddress:item.address withTitle:item.title withMapView:mapView];
        // [self addAnnotationAtAddress:item.address withTitle:item.title];
    }
}

+ (void)setRegion: (MKMapView *)mapView{
    MKCoordinateRegion currentRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [mapView setRegion:currentRegion animated:false];
}

+ (void)addAnnotationAtAddress: (NSString *)address withTitle:(NSString*)title withMapView:(MKMapView *)mapView {
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
            [mapView addAnnotation:annotation];
        }
    }];
}

//for later implementation. Plan to allow seller to set a pin for the pickup location instead of address, which will send in a coordinate instead. Can use this or implement a method to convert from coordinate to address.
+ (void)addAnnotationAtCoordinate: (CLLocationCoordinate2D)coordinate withMapView:(MKMapView*)mapView { //why no stars on this? is this not an object?
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"annotation!";
    [mapView addAnnotation:annotation];
}

+ (void)removeAllPinsButUserLocation: (MKMapView *)mapView {
    MKUserLocation *userlocation = mapView.userLocation;
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:mapView.annotations];
    if(userlocation != nil){
        [pins removeObject:userlocation];
    }
    [mapView removeAnnotations:pins];
    pins = nil;
}

+ (MKAnnotationView *)mapViewHelper:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
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

//filler for button target
+(void)annotationClicked{
    
}

+ (void)updateUserLocation: (MKMapView*)mapView{
    
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


@end
