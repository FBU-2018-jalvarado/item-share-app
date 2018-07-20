//
//  myPin.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Item.h"

@interface Pin : MKPointAnnotation

@property (strong, nonatomic) Item *item;

@end
