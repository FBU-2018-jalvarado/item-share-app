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

@interface MapViewController : UIViewController
//@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *filteredItemsArray;

- (void)removeAllPinsButUserLocation;
- (void)addAnnotations: (NSMutableArray *)filteredItemsArray;


@end
