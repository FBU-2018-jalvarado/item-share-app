//
//  MapViewController.h
//  ItemShareApp
//
//  Created by Nicolas Machado on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "MapModel.h"

//@interface CKMapKitViewController : UIViewController
//
//@end
//
//@interface CKAnnotationView : MKAnnotationView
//
//@end
//
//@interface CKClusterView : MKAnnotationView
//
//@end

@protocol MapViewControllerDelegate

- (void)openSideProfile;
- (void)dismissHUD;
- (void) showHUD;

@end

@interface MapViewController : UIViewController
//@property (strong, nonatomic) NSMutableArray *itemsArray;

@property (strong, nonatomic) NSMutableArray *filteredItemsArray;
@property (nonatomic, weak) id <MapViewControllerDelegate> mapDelegate;

- (void)removeAllMarkersButUserLocation;
- (void)addMarkers: (NSMutableArray *)filteredItemsArray;


@end
