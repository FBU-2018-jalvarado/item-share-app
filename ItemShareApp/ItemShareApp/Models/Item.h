//
//  Item.h
//  ItemShareApp
//
//  Created by Stephanie Lampotang on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "PFObject.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Item : PFObject<PFSubclassing>

//@property (strong, nonatomic) NSString _Nullable category;
//@property (strong, nonatomic) NSString _Nullable description;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) PFUser *owner;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSString *_Nullable address;
@property (strong, nonatomic) NSString *itemID;

+ (void) postItem: ( NSString * )title withOwner:( PFUser * )owner withLocation: ( CLLocation * )location withAddress:( NSString * _Nullable )address withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end
