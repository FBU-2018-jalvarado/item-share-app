//
//  PlaceholdViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol PlaceholderViewControllerDelegate

- (void)dismissToMap;
- (void)showSearchView;
-(void)dismissKeyboard;

@end

@protocol PlaceHolderViewControllerDelegateMap

//- (void)addAnnotations:(NSMutableArray *)filteredItemsArray;
//- (void)removeAllPinsButUserLocation;
- (void)addAnnotationsInMap:(NSMutableArray*)filteredItemArray;
- (void)removeAnnotationsInMap;


@end

@interface PlaceholdViewController : UIViewController
@property (nonatomic, weak) id <PlaceholderViewControllerDelegate> placeholderDelegate;
@property (nonatomic, weak) id <PlaceHolderViewControllerDelegateMap> placeholderDelegateMap;


@end