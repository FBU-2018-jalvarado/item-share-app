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
#import "Item.h"

@interface MapModel : NSObject

- (void)fetchItemsWithCompletion:(void(^)(NSArray<Item *> *items, NSError *error))completion;

@end
