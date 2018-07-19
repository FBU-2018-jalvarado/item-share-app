//
//  MapModel.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/19/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapModel : NSObject

+ (void)addAnnotations: (MKMapView*)mapView withArray: (NSMutableArray *)filteredItemsArray;
+ (void)setRegion: (MKMapView *)mapView;
+ (void)addAnnotationAtAddress: (NSString *)address withTitle:(NSString*)title withMapView:(MKMapView *)mapView;
+ (void)addAnnotationAtCoordinate: (CLLocationCoordinate2D)coordinate withMapView:(MKMapView*)mapView;
+ (void)removeAllPinsButUserLocation: (MKMapView *)mapView;
+ (MKAnnotationView *)mapViewHelper:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;
+ (void)updateUserLocation: (MKMapView*)mapView;
        
@end
