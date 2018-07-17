
//
//  User.m
//  ItemShareApp
//
//  Created by Stephanie Lampotang on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>

@implementation User

@dynamic name;
@dynamic itemsForSale;

//+ (nonnull NSString *)parseClassName {
//    return @"User";
//}


//+ (void) configureUser: ( NSString * )name withUsername:( NSString * )username withLocation: ( CLLocation * )location withAddress:( NSString * _Nullable )address withCompletion: completion {
//
//    Item *newItem = [Item new];
//    newItem.title = title;
//    newItem.location = location;
//    newItem.address = address;
//    newItem.owner = owner;
//
//    [newItem saveInBackgroundWithBlock: completion];
//}

//+ (void) configureUser: ( NSString * )name withUsername:( NSString * )username withLocation: ( CLLocation * )location withAddress:( NSString * _Nullable )address withCompletion: completion {
//
//        newItem.title = title;
//        newItem.location = location;
//        newItem.address = address;
//        newItem.owner = owner;
//
//        [newItem saveInBackgroundWithBlock: completion];
//    }

//PFUser changingThisUser = [PFUser.currentUser];
//changingThisUser[@"itemsForSale"] addObject:"pan"
//[changingThisUser saveToBackground];

@end


