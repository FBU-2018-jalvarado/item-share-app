//
//  User.m
//  item-share-app
//
//  Created by Tarini Singh on 7/24/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic name;
@dynamic email;
@dynamic itemsSelling;
@dynamic itemsPreviousRent;
@dynamic itemsCurrentRent; 
@dynamic itemsFutureRent;

+ (void) postUser: ( NSString * _Nullable )name withEmail:( NSString * _Nullable )email withCompletion: (PFBooleanResultBlock  _Nullable)completion {

    User *newUser = (User*)[PFUser currentUser];
    newUser.name = name;
    newUser.email = email;
    newUser.itemsSelling = [NSMutableArray new];
    newUser.itemsPreviousRent = [NSMutableArray new];
    newUser.itemsCurrentRent = [NSMutableArray new];
    newUser.itemsFutureRent = [NSMutableArray new];

    [newUser saveInBackgroundWithBlock: completion];
}

@end
