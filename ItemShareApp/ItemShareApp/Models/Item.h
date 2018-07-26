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
@class Booking;
#import <Parse/Parse.h>

@interface Item : PFObject<PFSubclassing>

//@property (strong, nonatomic) NSString _Nullable category;
//@property (strong, nonatomic) NSString _Nullable description;

@property (strong, nonatomic) NSString *_Nonnull title;
@property (strong, nonatomic) PFUser *_Nonnull owner;
@property (strong, nonatomic) CLLocation *_Nullable location;
@property (strong, nonatomic) NSString *_Nullable address;
@property (nonatomic, strong) NSMutableArray * _Nullable bookingsArray;
@property (strong, nonatomic) NSString  * _Nonnull itemID;
@property (strong, nonatomic) NSMutableArray *_Nullable categories;
@property (strong, nonatomic) NSString *_Nullable descrip;
@property (strong, nonatomic) PFFile *_Nullable image;
@property (strong, nonatomic) NSString *_Nullable booked;
@property (strong, nonatomic) NSNumber *_Nullable distanceToUser;

+ (void) postItem: ( NSString * _Nonnull )title withOwner:( PFUser * _Nonnull )owner withLocation: ( CLLocation * _Nullable )location withAddress:( NSString * _Nullable )address withCategories:(NSMutableArray *_Nullable)categories withDescription:(NSString *_Nullable)descrip withImage:(UIImage *_Nullable)image withBookedNowBool:(NSString *_Nullable)booked withDistance: (NSNumber *_Nullable)distanceToUser withCompletion: (PFBooleanResultBlock  _Nullable)completion;

-(BOOL) isBooked;

@end
