//
//  Booking.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/23/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"
#import "User.h"
@class Item;

@interface Booking : PFObject<PFSubclassing>

@property (strong, nonatomic) User *seller;
@property (strong, nonatomic) User *renter;
@property (strong, nonatomic) NSString *_Nullable address;
@property (strong, nonatomic) NSString *itemID;
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (strong, nonatomic) Item *item;

+ (void) postBooking: (Item *)item withSeller:( User * )seller withRenter: ( User * )renter withAddress:( NSString * _Nullable )address withStartTime:(NSDate *)startTime withEndTime:(NSDate *)endTime withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end
