//
//  Booking.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/23/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"
@class Item;

@interface Booking : PFObject<PFSubclassing>

@property (strong, nonatomic) PFUser *seller;
@property (strong, nonatomic) PFUser *renter;
@property (strong, nonatomic) NSString *_Nullable address;
@property (strong, nonatomic) NSString *itemID;
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (strong, nonatomic) Item *item;

+ (void) postBooking: (Item *)item withSeller:( PFUser * )seller withRenter: ( PFUser * )renter withAddress:( NSString * _Nullable )address withStartTime:(NSDate *)startTime withEndTime:(NSDate *)endTime withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end
