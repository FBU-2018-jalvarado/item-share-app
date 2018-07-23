//
//  Item.m
//  ItemShareApp
//
//  Created by Stephanie Lampotang on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "Item.h"

@implementation Item

@dynamic title;
@dynamic owner;
@dynamic location;
@dynamic address;
@dynamic itemID;
@dynamic bookingsArray;

+ (nonnull NSString *)parseClassName {
    return @"Item";
}

//- (BOOL)isAvailableOnDate:(NSDate *)date {
//    [FBUDateHelper dateConflicers:date1 yo: date];
//}

+ (void) postItem: ( NSString * )title withOwner:( PFUser * )owner withLocation: ( CLLocation * )location withAddress:( NSString * _Nullable )address withBooking: (Booking *)booking withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Item *newItem = [Item new];
    newItem.title = title;
    newItem.location = location;
    newItem.address = address;
    newItem.owner = owner;
    //add object to array;
    newItem.bookingsArray = [[NSMutableArray alloc] init];
//    [newItem.bookingsArray addObject:booking];
//    [newItem setObject:newItem.bookingsArray forKey:@"bookingsArray"];
    
    [newItem saveInBackgroundWithBlock: completion];
}

@end
